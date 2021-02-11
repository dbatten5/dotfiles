#!/usr/bin/env bash

script_name="$(basename -- "$0")"

function help_text() {
    echo ""
    echo "Usage:        ./$script_name COMMAND"
    echo ""
    echo "Helper script to automate some jira actions"
    echo ""
    echo "Available Commands:"
    echo "  new         Start a new ticket"
    echo "  ticket      View the current ticket in jira"
}

function die() {
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
}

function branchify_string() {
    local input_str
    read -r input_str
    sed -e 's/[()\.:]//g' -e 's/[[:blank:]]/-/g' <<< "$input_str" \
        | awk '{print tolower($1);}'
}

function check_for_unstaged_changes() {
    if [[ -n $(git status -s) ]]; then
        read -p "You have unstaged changes! Do you want to proceed? (y/n) " -n 1 -r
        echo

        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborting"
            die
        fi
    fi
}

function check_for_env() {
    local required_env_vars=("JIRA_EMAIL" "JIRA_API_TOKEN" "JIRA_BASE_API")
    for var_name in "${required_env_vars[@]}"; do
        [[ -z "${!var_name}" ]] && echo "$var_name not set!" && die
    done
}

function check_readiness() {
    check_for_env
    check_for_unstaged_changes
}

function new_ticket() {
    check_readiness

    read -p 'Please provide the Jira issue url: ' -r issue_url

    [[ -z "$issue_url" ]] && echo "Please enter a url!" && die

    local issue_id auth request_url body error

    issue_id="${issue_url##*/}"
    auth="${JIRA_EMAIL}:${JIRA_API_TOKEN}"
    request_url="${JIRA_BASE_API}/${issue_id}?fields=summary,description,issuetype"

    body=$(curl -s --user "$auth" "$request_url" -H "Accept: application/json")

    error=$(jq -r '.errorMessages[0]' <<< "$body")

    [[ "$error" != "null" ]] && echo "Error: ${error}" && die

    local default_ticket_summary ticket_type

    default_ticket_summary=$(jq -r '.fields.summary' <<< "$body" | branchify_string)
    ticket_type=$(jq -r '.fields.issuetype.name' <<< "$body")

    read -p "Enter branch name [${default_ticket_summary}]: " -r branch_description

    if [[ -z "$branch_description" ]]; then
        branch_description="$default_ticket_summary"
    else
        branch_description=$(branchify_string <<< "$branch_description")
    fi

    if [[ "$ticket_type" =~ "task" ]]; then
        ticket_type="task"
    fi

    local branch="${ticket_type,,}/${branch_description}/${issue_id}"

    echo "Switching to master branch..." && git checkout master
    echo "Pulling latest master..." && git pull origin HEAD
    echo "Switching to new branch..." && git checkout -b "$branch"
    echo "All done!"
}

function open_ticket() {
    local branch ticket_id
    branch=$(git branch --show-current)
    [[ "$branch" != *"/"* ]] && echo "No ticket id found" && return 0
    ticket_id="${branch##*/}"
    open "${JIRA_URL}/${ticket_id}"
}

if [[ -n $1 ]]; then
    case "$1" in
        new)
            new_ticket
            exit 0
            ;;
        ticket)
            open_ticket
            exit 0
            ;;
        *)
            echo "¯\\_(ツ)_/¯ What do you mean \"$1\"?"
            help_text
            exit 1
            ;;
    esac
else
    help_text
    exit 1
fi

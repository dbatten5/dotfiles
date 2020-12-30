#!/usr/bin/env bash

function die() {
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
}

function check_for_unstaged_changes() {
    if [[ -n $(git status -s) ]]; then
        read -p "You have unstaged changes! Do you want to proceed? " -n 1 -r
        echo
    fi
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborting"
        die
    fi
}

function check_for_env() {
    local required_env_vars=("JIRA_EMAIL" "JIRA_API_TOKEN" "JIRA_BASE_URL")
    for var_name in "${required_env_vars[@]}"; do
        [[ -z "${!var_name}" ]] && echo "$var_name not set!" && die
    done
}

function check_readiness() {
    check_for_env
    check_for_unstaged_changes
}

function main() {
    check_readiness

    read -p 'Please provide the Jira issue url: ' issue_url

    [ -z "$issue_url" ] && echo "Please enter a url!" && exit 1

    local issue_id body error

    issue_id="${issue_url##*/}"

    body=$(
        curl -s --user "${JIRA_EMAIL}:${JIRA_API_TOKEN}" "${JIRA_BASE_URL}/${issue_id}?fields=summary,description,issuetype" -H "Accept: application/json"
    )

    error=$(jq -r '.errorMessages[0]' <<< "$body")

    [ "$error" != "null" ] && echo "Error: ${error}" && exit 1

    local default_ticket_summary ticket_type

    default_ticket_summary=$(jq -r '.fields.summary' <<< "$body" |
        sed -e 's/[()\.:]//g' -e 's/[[:blank:]]/-/g'  |
        awk '{print tolower($1);}'
    )
    ticket_type=$(jq -r '.fields.issuetype.name' <<< "$body")

    read -p "Enter branch name [${default_ticket_summary}]: " branch_description

    if [[ -z "$branch_description" ]]; then
        branch_description="$default_ticket_summary"
    else
        branch_description=$(sed -e 's/[[:blank:]]/-/g' <<< "$branch_description")
    fi

    if [[ "$ticket_type" =~ "task" ]]; then
        ticket_type="task"
    fi

    local branch="${ticket_type}/${branch_description}/${issue_id}"

    echo "Switching to master branch..." && git checkout master
    echo "Pulling latest master..." && git pull origin HEAD
    echo "Switching to new branch..." && git checkout -b "$branch"
    echo "All done!"
}

main "$@"

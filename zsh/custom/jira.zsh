# start a new jira ticket
function jira() {
  if [[ -n $(git status -s) ]]; then
    echo "You have unstaged changes! Aborting" && return 0
  fi

  read "issue_url?Please provide the Jira issue url: "

  [ -z "$issue_url" ] && echo "Please enter a url!" && return 0

  issue_id=${issue_url##*/}

  request_url="${JIRA_BASE_URL}/${issue_id}?fields=summary,description,issuetype"

  body=$(
    curl -s --user ${JIRA_EMAIL}:${JIRA_API_TOKEN} ${request_url} -H "Accept: application/json"
  )

  error=$(jq -r '.errorMessages[0]' <<< ${body})

  [ "$error" != "null" ] && echo "Error: ${error}" && return 0

  default_ticket_summary=$(jq -r '.fields.summary' <<< ${body} |
    sed -e 's/[()\.:]//g' -e 's/[[:blank:]]/-/g'  |
    awk '{print tolower($1);}'
  )
  ticket_type=${$(jq -r '.fields.issuetype.name' <<< ${body}):l}

  read "branch_description?Enter branch name [${default_ticket_summary}]: "

  if [[ -z "$branch_description" ]]; then
    branch_description="$default_ticket_summary"
  else
    branch_description=$(sed -e 's/[[:blank:]]/-/g' <<< ${branch_description})
  fi

  if [[ "$ticket_type" =~ "task" ]]; then
    ticket_type="task"
  fi

  branch="${ticket_type}/${branch_description}/${issue_id}"

  echo "Switching to master branch..." && git checkout master
  echo "Pulling latest master..." && git pull origin HEAD
  echo "Switching to new branch..." && git checkout -b "$branch"
  echo "All done!"
}

# scripts

These scripts provide some automation around tasks that I do regularly.

## jira

### requirements

* `bash` version 4.2+
* `jq`
* `git`
* `curl`

This is a bash script to automate some repetitive local jira actions. 

Before running the script, ensure the following `env` variables have been set:

```bash
JIRA_EMAIL # the email linked to your jira account
JIRA_API_TOKEN # created here https://id.atlassian.com/manage-profile/security/api-tokens
JIRA_BASE_API # the base url of your jira api eg. https://acme.atlassian.net/rest/api/2/issue
JIRA_URL # the base url of your jira application eg. https://acme.atlassian.net/browse
```

Add it to your `usr/local/bin` directory with `ln -sv /absolute/path/to/jira.sh /usr/local/bin/jira`
so you can call it from wherever, assuming `/usr/local/bin` is in your `$PATH`.

### commands

```bash
$ jira new
```

Running this command will do the following:

1. Prompt the user for a jira issue url
2. Ask for a branch name, giving the issue title as the default. **NB**, spaces
   will be interpreted as dashes so can type as if it's a sentence. **NNB**,
   the branch name will be in the following format: `{issue_type}/{branch_name}/{issue_id}`
3. On submit, it will branch off latest master to a new branch with the above
   name

```bash
$ jira ticket
```

Running this command will open the current ticket (based on the git branch) in your browser.

## spotify

This is an `applescript` to automate some spotify based actions. 
Add it to your `usr/local/bin` directory with  

```bash
ln -sv /absolute/path/to/spotify /usr/local/bin/spotify
```

### commands

```bash
$ spotify yt
```

This opens the currently playing song as a youtube search. This also works
quite well as a toolbar shortcut, which you can do by ripping out the body of
the command from the script and adding it as a "Quick Action" in the Mac
Automator app. From there it can be added to the toolbar, plenty of
documentation online on how to do that.

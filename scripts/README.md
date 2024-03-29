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
$ jira view
```

Running this command will open the current ticket (based on the git branch) in your browser.

## spotify

This is a set of `applescript` scripts to automate some spotify based actions.

### commands

```bash
$ open_youtube
```

This opens the currently playing song as a YouTube search, mostly so I can ~see
how many plays it has~ read the comments. This also works quite well as a
toolbar shortcut, which you can do by ripping out the body of the command from
the script and adding it as a "Quick Action" in the Mac Automator app. From
there it can be added to the toolbar, plenty of documentation online on how to
do that.

```bash
$ volume_down
$ volume_up
```

Adjusts the Spotify volume. Useful to assign it to the touchbar or to a function
key so the volume can be controlled while on a different app.

## f45

Give me a random f45 video from my video collection so I don't have to decide.

### usage

```bash
$ f45
$ f45 cardio  # to return only cardio videos
$ f45 strength  # to return only strength videos
```

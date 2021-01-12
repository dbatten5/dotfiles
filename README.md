# dotfiles

Here are the configuration files for the various tools I use along with a bunch 
of custom scripts and shell helper functions to reduce repetitive tasks.

## bootstrap.sh

This is intended to be a shell script to install everything I like on a fresh
MacBook. I wouldn't recommend anyone run the script on their own machine,
partly as the script in its current state is fairly experimental and hasn't
been tested thoroughly, and partly as its rarely a good idea to install someone
else's setup in its entirety.

The script should do roughly the following:

1. Install some useful packages & casks via brew.
2. Install `oh-my-zsh`.
3. Symlink a bunch of config files found in this repo to the relevant places.
4. Install some useful python packages.
5. Configure some OSX settings.

## zsh

I've leveraged the `oh-my-zsh` custom directory pattern and split out my
`functions`, `aliases`, `exports` etc. into separate `.zsh` files in
`zsh/custom`.

The `alias.zsh`, `export.zsh` and `keybind.zsh` files are largely
self-documenting.

### functions

The majority of the functions defined in `zsh/custom/function.zsh` are powered
by `fzf` and are focused on the following topics:

#### general

|name|description|keybinding|
|---|---|---|
|fza|find an alias and paste to command line|<kbd>Ctrl</kbd>+<kbd>f</kbd> <kbd>Ctrl</kbd>+<kbd>a</kbd>|
|fzh|find a command from history and paste to command line|<kbd>Ctrl</kbd>+<kbd>r</kbd>|
|z|called without arguments to find a directory from `z` plugin's list, with <br/> arguments acts like normal `z`|
|ssh|called without arguments to find a remote, with arguments to be regular <br/> ssh (requires `rg`)|
|vs|open a readonly `nvim` buffer reading from `stdout` from a given command. <br/> usage `vs ls -lA`|
|. `n`|find a directory to cd into at `n` levels (defaults to 1)|
||copy the current line to the system clipboard|<kbd>Ctrl</kbd>+<kbd>y</kbd>|
|clc|copy the previous command to the system clipboard|
|pubkey|copy my public key to the system clipboard|
|please|sudo the last command|

#### git

|name|description|keybinding|
|---|---|---|
|fzgf|find a commit to fixup|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>f</kbd>|
|fzgr|find a commit to rebase onto|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>r</kbd>|
|gfix|fixup the latest commit|
|greb `n`|rebase latest `n` commits (defaults to 1)|

#### docker

|name|description|
|---|---|
|dexec|find a container to drop into|
|dlog|find a container to retrieve logs|
|dstart|find a stopped container to start|
|dstop|find a started container to stop|

#### kubernetes

|name|description|
|---|---|
|klog|retrieve logs for a container|
|kdescp|describe a pod|
|kdesc|describe a resource|
|kexec|drop into a container shell|
|kns `ns`|switch namespaces to `ns`. if no argument given then choose from a list|
|kyaml|get yaml for a resource|
|kctx|switch context|
|ktmp|create a temporary busybox pod|
|kcsec `a1` `a2` `a3`|copy secret `a1` from namespace `a2` to namespace `a3`. <br/>If arguments are omitted then user is prompted|

## scripts

These are located in `scripts` and provide some automation around tasks that I
do regularly.

### jira (wip)

#### requirements

* `bash` version 4.2+
* `jq`
* `git`
* `curl`

This is a bash script to automate some repetitive local jira actions. 

Before running the script, ensure the following `env` variables have been set:

```bash
JIRA_EMAIL # the email linked to your jira account
JIRA_API_TOKEN # created here https://id.atlassian.com/manage-profile/security/api-tokens
JIRA_BASE_URL # the base url of your jira api eg. https://acme.atlassian.net/rest/api/2/issue
```

Running the script will do the following:

1. Prompt the user for a jira issue url
2. Ask for a branch name, giving the issue title as the default. **NB**, spaces
   will be interpreted as dashes so can type as if it's a sentence. **NNB**,
   the branch name will be in the following format: `{issue_type}/{branch_name}/{issue_id}`
3. On submit, it will branch off latest master to a new branch with the above
   name

Add it to your `usr/local/bin` directory with `ln -sv /absolute/path/to/jira.sh /usr/local/bin/jira`
so you can call it from wherever, assuming `/usr/local/bin` is in your `$PATH`.

## vim

To get up and running with a minimal vimrc:

```bash
vimrc="${HOME:-~}/.vimrc"
[[ ! -f $vimrc ]] \
  && curl https://raw.githubusercontent.com/dbatten5/dotfiles/main/vim/base_vimrc -o "$vimrc" \
  || echo ".vimrc already exists, not overwriting..."
```

More coming soon...

# dotfiles

Here are the configuration files for the various tools I use along with a bunch 
of custom scripts and shell helper functions to reduce repetitive tasks.

## bootstrap.sh

This is intended to be a shell script to install everything I like on a fresh
MacBook. I wouldn't recommend anyone run the script on their own machine,
partly as the script in its current state is fairly experimental and hasn't
been tested thoroughly, and partly as it's rarely a good idea to install someone
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
||copy the current line to the system clipboard|<kbd>Ctrl</kbd>+<kbd>y</kbd>|
|clc|copy the previous command to the system clipboard|
|pubkey|copy my public key to the system clipboard|
|please|sudo the last command|
|v|open suspended nvim session if it exists or start afresh|
|cpf `f`|copy the contents of file `f` to the clipboard, <br/>without arguments to fzf the file|

#### git

|name|description|keybinding|
|---|---|---|
|fzgf|find a commit to fixup|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>f</kbd>|
|fzgr|find a commit to rebase onto|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>r</kbd>|
|fzgs|find a commit to show|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>s</kbd>|
|fzgsp|find a stash to pop|<kbd>Ctrl</kbd>+<kbd>g</kbd> <kbd>Ctrl</kbd>+<kbd>p</kbd>|
|gfix|fixup the latest commit|
|greb `n`|rebase latest `n` commits (defaults to 1)|
|gb|with arguments acts as normal `git branch`. <br/>without arguments it brings up a menu to fzf a branch to checkout. <br/>Use <kbd>Ctrl</kbd>+<kbd>d</kbd> to delete the branch under the cursor|

#### docker

|name|description|
|---|---|
|dexec|find a container to drop into|
|dlog|find a container to retrieve logs|
|dstart|find a stopped container to start|
|dstop|find a started container(s) to stop|
|dimagerm|find images to delete|

#### kubernetes

|name|description|
|---|---|
|klog|retrieve logs for a container|
|kdescp|describe a pod|
|kdesc|describe a resource|
|kexec|drop into a container shell|
|kns `ns`|switch to namespace `ns` or choose from a list if omitted|
|kyaml|get yaml for a resource|
|kctx|switch context|
|ktmp|create a temporary busybox pod|
|kcsec `sec` `ns1` `ns2`|copy secret `sec` from namespace `ns1` to namespace `ns2`. <br/>If arguments are omitted then user is prompted|
|kscaledown|scale down all deployments and stateful sets in the current namespace|
|kscaleup|scale up all deployments and stateful sets in the current namespace|

#### helm
|name|description|
|---|---|
|hun|uninstall a chart|

## scripts

These are located in `scripts` and provide some automation around tasks that I
do regularly. See the [README](scripts/README.md) there for more information.

## vim

To get up and running with a minimal vimrc:

```bash
vimrc="${HOME:-~}/.vimrc"
[[ ! -f $vimrc ]] \
  && curl https://raw.githubusercontent.com/dbatten5/dotfiles/main/vim/base_vimrc -o "$vimrc" \
  || echo ".vimrc already exists, not overwriting..."
```

More coming soon...

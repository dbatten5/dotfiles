# Dotfiles

Here are the configuration files for the various tools I use, with the majority
for my `neovim` and `zsh` setup.

## bootstrap.sh

This is intended to be a shell script to install everything I like on a fresh
MacBook. I wouldn't recommend anyone run the script on their own machine,
partly as the script in its current state is fairly experimental and hasn't
been tested thoroughly, and partly as its rarely a good idea to install someone
else's setup in its entirety.

The script should do roughly the following:

1. Install some useful packages & casks via brew (notably `zsh`).
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
|fza|find an alias and paste to command line|<kbd>Ctrl</kbd>+<kbd>a</kbd>
|fzh|find a command from history and paste to command line|<kbd>Ctrl</kbd>+<kbd>b</kbd>
|z|called without arguments to find a directory from `z` plugin's list, <br/>with arguments acts like normal `z`

#### git

|name|description|keybinding|
|---|---|---|
|fzgf|find a commit to fixup|<kbd>Ctrl</kbd>+<kbd>g</kbd><kbd>Ctrl</kbd>+<kbd>f</kbd>
|fzgr|find a commit to rebase|<kbd>Ctrl</kbd>+<kbd>g</kbd><kbd>Ctrl</kbd>+<kbd>r</kbd>

#### docker

|name|description|
|---|---|
|dexec|find a container to drop into
|dlog|find a container to retrieve logs

#### kubernetes

|name|description|
|---|---|
|klog|retrieve logs for a container
kdescp|describe a pod
kdesc|describe a resource
kexec|drop into a container shell
kns|switch namespaces
kyaml|get yaml for a resource

## nvim

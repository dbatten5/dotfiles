setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE

setopt NO_BEEP
setopt CORRECT

fpath=(~/.zshfn $fpath)
autoload -U $fpath[1]/*(.:t)

source ~/.zshkb

# ALIASES {{{1

# quick editing and sourcing of config files
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias config='nvim ~/.config'

# GENERAL {{{1
# copy public key to clipboard
alias pubkey='clipcopy "$(cat ~/.ssh/id_rsa.pub)" && echo "=> Public key copied to clipboard."'
# copy last command to clipboard
alias clc='clipcopy "$(fc -ln -1)" && echo "=> Last command copied to clipboard."'
# sudo last command
alias please='sudo "$SHELL" -c "$(fc -ln -1)"'
alias o='open'

# VIM {{{1
alias v="nvim ."
alias vim="nvim"

# GIT {{{1
alias gbd='git branch --merged | egrep -v "(^\*|master|main|dev|staging|develop)" | xargs git branch -d'

function git_main_branch() {
  git branch 2> /dev/null \
  | grep -o -m 1 \
    -e ' main$' \
    -e ' master$' \
  | xargs \
  || return
}

# Common commands
alias gco='git checkout'
alias gst='git status'
alias blame='git blame'
alias ggpull='git pull origin $(git_main_branch)'
alias gcp='git cherry-pick'
alias gl='git log'
alias gs='git status'
alias gc='git commit'
alias ga='git add'
alias gb='git branch'
# Push to origin/current branch
alias ggpush='git push origin \`git rev-parse --abbrev-ref HEAD\`'
# Force push
alias gpf='git push --force-with-lease origin'
# Change the most recent commit message
alias gca='git commit --amend'
# Rebase all commits in current branch
alias grb='git rebase \`git rev-list $(git_main_branch).. | tail -1\`^'
# Interactive rebase all commits in current branch
alias grbi='git rebase -i \`git rev-list $(git_main_branch).. | tail -1\`^'
# Autosquash all commits in current branch
alias grbas='git rebase --autosquash -i \`\$(git rev-list $(git_main_branch).. | tail -1)^\`'
# Remove branches that don't exist on remote, prune all unreachable objects
alias gprune='git fetch --prune --prune-tags && git prune'

# PYTHON {{{1
alias c='conda'
alias dj='python manage.py'

# KUBERNETES {{{1
alias kex='kubectl explain'
alias kcns='kubectl config view --minify --output "jsonpath={..namespace}"'
alias -g KAN='--all-namespaces'
alias -g KDR='--dry-run=client -o yaml'

# DOCKER {{{1
alias d='docker'
alias dc='docker compose'
alias drma='docker container rm $(docker ps -aq) -f'

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/projects"

alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh --color'
alias la='ls -lAh --color'

# EXPORTS {{{1

export FZF_DEFAULT_OPTS="
  --height=40%
  --min-height=25
  --info=inline
  --preview-window='right:60%'
  --layout=reverse
  --bind='ctrl-d:half-page-down'
  --bind='ctrl-u:half-page-up'
  --bind='ctrl-a:select-all+accept'
  --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind='?:toggle-preview'
  --bind='ctrl-e:execute(echo {+} | xargs -o nvim)'
  --bind='ctrl-x:unix-line-discard'
"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"
export DJANGO_CONFIGURATION="PWLManagementCommand"

# INITIALISING PACKAGES

eval $(/opt/homebrew/bin/brew shellenv)

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Created by `pipx` on 2023-12-24 10:00:49
export PATH="$PATH:/Users/dom.batten/.local/bin"
eval "$(/opt/homebrew/bin/brew shellenv)"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
export WORKON_HOME=$HOME/.virtualenvs
pyenv virtualenvwrapper

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/Applications/Postgres.app/Contents/Versions/15/bin:$PATH"

# Invoke tab-completion script to be sourced with the Z shell.
# Known to work on zsh 5.0.x, probably works on later 4.x releases as well (as
# it uses the older compctl completion system).

_complete_invoke() {
    # `words` contains the entire command string up til now (including
    # program name).
    #
    # We hand it to Invoke so it can figure out the current context: spit back
    # core options, task names, the current task's options, or some combo.
    #
    # Before doing so, we attempt to tease out any collection flag+arg so we
    # can ensure it is applied correctly.
    collection_arg=''
    if [[ "${words}" =~ "(-c|--collection) [^ ]+" ]]; then
        collection_arg=$MATCH
    fi
    # `reply` is the array of valid completions handed back to `compctl`.
    # Use ${=...} to force whitespace splitting in expansion of
    # $collection_arg
    reply=( $(invoke ${=collection_arg} --complete -- ${words}) )
}


# Tell shell builtin to use the above for completing our given binary name(s).
# * -K: use given function name to generate completions.
# * +: specifies 'alternative' completion, where options after the '+' are only
#   used if the completion from the options before the '+' result in no matches.
# * -f: when function generates no results, use filenames.
# * positional args: program names to complete for.
compctl -K _complete_invoke + -f invoke inv

# vim: set ft=sh :

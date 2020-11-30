# CONFIG FILES {{{1
alias ez='vim ~/.oh-my-zsh/custom'
alias sz='source ~/.zshrc'
alias eb='vim ~/.bash_profile'
alias sb='source ~/.bash_profile'
alias config='nvim ~/.config'

# GENERAL {{{1
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# VIM {{{1
alias vim="nvim"
alias v="nvim ."

# GIT {{{1
alias grbm='git pull --rebase=interactive origin master'
alias gbd='git branch --merged | egrep -v "(^\*|master|main|dev|staging|develop)" | xargs git branch -d'
alias gpf='ggpush --force-with-lease'

# ANSIBLE {{{1
alias ap='ansible-playbook'

# PYTHON {{{1
alias c='conda'
alias dj='python manage.py'


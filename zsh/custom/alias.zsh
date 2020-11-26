# CONFIG FILES
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias eb='vim ~/.bash_profile'
alias sb='source ~/.bash_profile'
alias config='nvim ~/.config'

# VIM
alias vim="nvim"
alias v="nvim ."

# GIT
alias grbm='git pull --rebase=interactive origin master'
alias gbd='git branch --merged | egrep -v "(^\*|master|dev|staging|develop)" | xargs git branch -d'
alias gpf='ggpush --force-with-lease'

# ANSIBLE
alias ap='ansible-playbook'

# GENERAL
alias pubkey="cat ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# PYTHON
alias c='conda'
alias dj='python manage.py'

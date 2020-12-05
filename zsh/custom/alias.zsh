# CONFIG FILES {{{1
# quick editing and sourcing of config files
alias ez='vim ~/.oh-my-zsh/custom'
alias sz='source ~/.zshrc'
alias eb='vim ~/.bash_profile'
alias sb='source ~/.bash_profile'
alias config='nvim ~/.config'

# GENERAL {{{1
# copy public key to clipboard
alias pubkey='clipcopy "$(cat ~/.ssh/id_rsa.pub)" | echo "=> Public key copied to clipboard."'
# copy last command to clipboard
alias clc='clipcopy "$(fc -ln -1)" | echo "=> Last command copied to clipboard."'
# sudo last command
alias please='sudo "$SHELL" -c "$(fc -ln -1)"'

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

# HELM {{{1
alias h='helm'

# KUBERNETES {{{1
alias kdr='kubectl --dry-run=client -o yaml'
alias kex='kubectl explain'

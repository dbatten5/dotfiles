# quick editing and sourcing of config files
alias ez='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias config='nvim ~/.config'

# copy public key to clipboard
alias pubkey='clipcopy "$(cat ~/.ssh/id_rsa.pub)" && echo "=> Public key copied to clipboard."'
# copy last command to clipboard
alias clc='clipcopy "$(fc -ln -1)" && echo "=> Last command copied to clipboard."'
# sudo last command
alias please='sudo "$SHELL" -c "$(fc -ln -1)"'
alias o='open'

alias v="nvim ."
alias vim="nvim"

# git
alias gbd='git branch --merged | egrep -v "(^\*|master|main|dev|staging|develop)" | xargs git branch -d'
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
# Create a PR using gh
alias pr='gh pr create'

# python
alias c='conda'
alias dj='python manage.py'

# k8s
alias kex='kubectl explain'
alias kcns='kubectl config view --minify --output "jsonpath={..namespace}"'
alias -g KAN='--all-namespaces'
alias -g KDR='--dry-run=client -o yaml'

# docker
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

# display
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh --color'
alias la='ls -lAh --color'

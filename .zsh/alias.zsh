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
alias vv="nvim"
alias vim="nvim"

# git
alias gbd='git branch --merged | grep -Ev "(^\*|^\+|master|main|dev|staging|develop)" | xargs git branch -d'
alias gco='git checkout'
alias gcob='git checkout -b '
alias ggpull='git pull origin $(git_main_branch)'
alias gl='git log'
alias gs='git status'
alias gb='git branch'
alias gcom='git checkout $(git_main_branch)'
alias gar='git absorb -r'
# Push to origin/current branch
alias ggpush='git push origin HEAD'
# Force push
alias gpf='git push --force-with-lease origin'
# Change the most recent commit message
alias gca='git commit --amend'
alias grb='git rebase'
alias grbi='git rebase -i'
# Rebase the alternate branch
alias grba='git rebase -i -'
# Autosquash all commits in current branch
alias grbas='git rebase --autosquash -i \`\$(git rev-list $(git_main_branch).. | tail -n 1)^\`'
# Remove branches that don't exist on remote, prune all unreachable objects
alias gprune='git fetch --prune --prune-tags && git prune'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "--wip--" && git reset HEAD~'
alias g='git status -sb'
alias gz='git zero'
alias glm='git log --oneline origin/$(git defaultbranch)..'
alias gro='git pull --rebase=i origin/$(git defaultbranch)'
alias gw='git worktree'

# github
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
alias ls='lsd'
alias l='lsd -la'
alias la='lsd -a'
alias ll='lsd -l'
alias lt='lsd --tree --depth 10'

alias claude='with1pass claude'

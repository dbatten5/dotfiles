# GIT {{{1
function fixup() {
  local current_sha="$(git rev-parse HEAD)"

  git commit --fixup $current_sha
}

function rhead() {
  git rebase -i HEAD~$1
}

# KUBERNETES {{{1
# create a temporary busybox pod
function ktmp() {
  local cmd="${*:-sh}"
  kubectl run tmp-`date +%s` --rm -it --image=busybox -- "$cmd"
}

# FZF {{{1
# GENERAL {{{2
# fzf an alias and paste to command-line
function fza() {
  local sel="$(alias | fzf | cut -d= -f1)"
  [ -n "$sel" ] && print -z -- ${sel}
}

# fza but as a widget to be used with a key binding
function _fuzzy-alias() {
  local sel="$(alias | fzf | cut -d= -f1)"
  if [ -n "$sel" ]; then
    LBUFFER="$sel"
    RBUFFER=''
  fi
  [ -n "$widgets[autosuggest-clear]" ] && zle autosuggest-clear
  zle reset-prompt
}

zle -N _fuzzy-alias
bindkey -M viins '^f^a' _fuzzy-alias

# fzf in history and paste to command-line
fzh() {
  local selh="$(history -1 0 | fzf --query="$@" --ansi --no-sort -m -n 2.. | awk '{ sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print }')"
  [ -n "$selh" ] && print -z -- ${selh}
}

# fzh but as a widget to be used with a key binding
_fuzzy-history() {
  local selh="$(history -1 0 | fzf --query="$BUFFER" --ansi --no-sort -m -n 2.. | awk '{ sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print }')"
  if [ -n "$selh" ]; then
    LBUFFER="$selh"
    RBUFFER=''
  fi
  [ -n "$widgets[autosuggest-clear]" ] && zle autosuggest-clear
  zle reset-prompt
}

zle -N _fuzzy-history
bindkey -M viins '^r' _fuzzy-history

# GIT {{{2
# fzf a commit to fixup
function fzgf() {
  local preview files
  files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
  preview="echo {} |grep -Eo '[a-f0-9]+' |head -1 |xargs -I% git show --color=always % -- $files"
  git log -n ${1:-20} --oneline | fzf --preview="$preview" | cut -d' ' -f 1 | xargs git commit --no-verify --fixup
}

zle -N fzgf
bindkey -M viins '^g^f' fzgf

# DOCKER {{{2
# fzf a docker container
function _fuzzy-docker-container() {
  docker ps --format "{{.Names}}" | fzf
}

# drop into a container shell
function dexec() {
  docker exec -it $(_fuzzy-docker-container) /bin/bash
}

# retrieve logs
function dlog() {
  docker logs "$@" $(_fuzzy-docker-container)
}

# KUBERNETES {{{2
# fzf a pod
function _fuzzy-pod() {
  kubectl get pods |
    sed $'s/ /\u00a0\/' |
    fzf --header-lines=1 -d $'\u00a0' --nth=1 |
    awk $'{gsub("\u00a0", ""); print $1;}'
}

# fzf a container
function _fuzzy-pod-container() {
  kubectl get pods -o go-template-file="$HOME/projects/personal/dotfiles/zsh/custom/podlist.gotemplate" |
    column -t |
    fzf |
    awk '{print $1,$2;}'
}

# fzf a namespace
function _fuzzy-namespace() {
  kubectl get namespace |
    sed $'s/ /\u00a0\/' |
    fzf --header-lines=1 -d $'\u00a0' --nth=1 |
    awk $'{gsub("\u00a0", ""); print $1;}'
}

# retrieve logs for a pod
function klogp() {
  kubectl logs pod $(_fuzzy-pod) "$@"
}

# retrieve logs for a container
function klogc() {
  local pc=($(_fuzzy-pod-container))
  kubectl logs pod $pc[1] -c $pc[2] "$@"
}

# describe a pod
function kdescp() {
  kubectl describe pod $(_fuzzy-pod) "$*"
}

# drop into a container shell
function kexec() {
  local pc=($(_fuzzy-pod-container))
  kubectl exec -it $pc[1] -c $pc[2] -- /bin/bash
}

# switch namespaces
function kns() {
  kubectl config set-context --current --namespace=$(_fuzzy-namespace)
}

# GENERAL {{{1
# copy to clipboard
function clipcopy() {
  echo -n "$*" | pbcopy
}

# GIT {{{1
# fixup latest commit
function gfix1() {
  git commit --fixup $(git rev-parse HEAD)
}

# rebase latest commit
function greb1() {
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
  [ -n "$sel" ] && print -z -- "$sel"
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
function fzh() {
  local selh="$(history -1 0 | fzf --query="$@" --ansi --no-sort -m -n 2.. | awk '{ sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print }')"
  [ -n "$selh" ] && print -z -- "$selh"
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
  preview="echo {} | grep -Eo '[a-f0-9]+' | head -1 | xargs -I% git show --color=always % -- $files"
  git log -n ${1:-20} --oneline | fzf --preview="$preview" | cut -d' ' -f 1 | xargs git commit --no-verify --fixup
}

zle -N fzgf
bindkey -M viins '^g^f' fzgf

# DOCKER {{{2
# fzf a docker container
function _fuzzy-docker-container() {
  docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.CreatedAt}}" |
    fzf --header-lines=1 --delimiter='\s+' --nth=1,2 |
    awk '{print $1;}'
}

# drop into a container shell
function dexec() {
  local cmd="${*:-/bin/bash}"
  docker exec -it $(_fuzzy-docker-container) "$cmd"
}

# retrieve logs
function dlog() {
  docker logs "$@" $(_fuzzy-docker-container)
}

# KUBERNETES {{{2
# fzf a pod
function _fuzzy-k8s-pod() {
  kubectl get pods |
    fzf --header-lines=1 --delimiter='\s+' --nth=1 |
    awk '{print $1;}'
}

# fzf a container
function _fuzzy-k8s-pod-container() {
  kubectl get pods -o go-template-file="$HOME/.k8s/templates/podlist.gotemplate" |
    column -t |
    fzf --header-lines=1 |
    awk '{print $1,$2;}'
}

# generate a pod + container string for use with kubectl
function _fuzzy-k8s-kubectl-pc() {
  echo $(_fuzzy-k8s-pod-container) | awk '{printf "%s -c %s", $1, $2;}'
}

# fzf a namespace
function _fuzzy-k8s-namespace() {
  kubectl get namespace |
    fzf --header-lines=1 --delimiter='\s+' --nth=1 |
    awk '{print $1;}'
}

# fzf all
function _fuzzy-k8s-all() {
  kubectl get all -o custom-columns=KIND:.kind,NAME:.metadata.name |
    fzf --header-lines=1 |
    awk '{print tolower($1),$2;}'
}

# retrieve logs for a container
function klog() {
  kubectl logs $(_fuzzy-k8s-kubectl-pc) "$@"
}

# describe a pod
function kdescp() {
  kubectl describe pod $(_fuzzy-k8s-pod) "$*"
}

# describe a resource
function kdesc() {
  kubectl describe $(_fuzzy-k8s-all) "$*"
}

# drop into a container shell
function kexec() {
  local cmd="${*:-/bin/bash}"
  kubectl exec -it $(_fuzzy-k8s-kubectl-pc) -- "$cmd"
}

# switch namespaces
function kns() {
  kubectl config set-context --current --namespace=$(_fuzzy-k8s-namespace)
}

# get yaml for a resource
function kyaml() {
  kubectl get $(_fuzzy-k8s-all) -o yaml
}

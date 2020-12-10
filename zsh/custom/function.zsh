# GENERAL {{{1
# copy to clipboard
function clipcopy() {
  echo -n "$*" | pbcopy
}

# GIT {{{1
# fixup latest commit
function gfix1() {
  git commit --fixup "$(git rev-parse HEAD)"
}

# rebase latest commit
function greb() {
  git rebase -i HEAD~"${1:-1}"
}

# KUBERNETES {{{1
# create a temporary busybox pod
function ktmp() {
  local cmd="${*:-sh}"
  kubectl run tmp-"$(date +%s)" --rm -it --image=busybox -- "$cmd"
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
  zle reset-prompt
}

zle -N _fuzzy-alias

# fzf in history and paste to command-line
function fzh() {
  local selh="$(history -1 0 | fzf --query="$@" --ansi --no-sort -m -n 2.. | awk '{sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print;}')"
  [ -n "$selh" ] && print -z -- "$selh"
}

# fzh but as a widget to be used with a key binding
function _fuzzy-history() {
  local selh="$(history -1 0 | fzf --query="$BUFFER" --ansi --no-sort -m -n 2.. | awk '{sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print;}')"
  if [ -n "$selh" ]; then
    LBUFFER="$selh"
    RBUFFER=''
  fi
  zle reset-prompt
}

zle -N _fuzzy-history

# like normal z when used with arguments but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --nth 2.. +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# GIT {{{2
# fzf a commit to fixup
function fzgf() {
  local preview files
  files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
  preview="echo {} | grep -Eo '[a-f0-9]+' | head -1 | xargs -I% git show --color=always % -- $files"
  git log -n ${1:-20} --oneline | fzf --preview="$preview" | cut -d' ' -f 1 | xargs git commit --no-verify --fixup
}

zle -N fzgf

# fzf a commit to rebase current branch
function fzgr() {
  local preview files
  files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
  preview="echo {} | grep -Eo '[a-f0-9]+' | head -1 | xargs -I% git show --color=always % -- $files"
  git log -n ${1:-20} --oneline | fzf --preview="$preview" | cut -d' ' -f 1 | xargs git rebase -i
}

zle -N fzgf

# DOCKER {{{2
# fzf a docker container
function _fuzzy-docker-container() {
  docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.CreatedAt}}" |
    fzf --header-lines=1 --delimiter='\s+' --nth=1,2 |
    awk '{print $1;}'
}

# drop into a container shell
function dexec() {
  local cid=$(_fuzzy-docker-container)
  [ -n "$cid" ] && docker exec -it "$cid" "${*:-/bin/bash}"
}

# retrieve logs
function dlog() {
  local cid=$(_fuzzy-docker-container)
  [ -n "$cid" ] && docker logs "$@" "$cid"
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
  local pc="$(_fuzzy-k8s-pod-container)"
  [ -n "$pc" ] && echo "$pc" | awk '{print $1,"-c",$2;}'
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
  local pc=$(_fuzzy-k8s-kubectl-pc)
  [ -n "$pc" ] && kubectl logs ${=pc} "$@"
}

# describe a pod
function kdescp() {
  local pod=$(_fuzzy-k8s-pod)
  [ -n "$pod" ] && kubectl describe pod "$pod" "$@"
}

# describe a resource
function kdesc() {
  local res=$(_fuzzy-k8s-all)
  [ -n "$res" ] && kubectl describe ${=res} "$@"
}

# drop into a container shell
function kexec() {
  local pc=$(_fuzzy-k8s-kubectl-pc)
  [ -n "$pc" ] && kubectl exec -it ${=pc} -- "${*:-/bin/bash}"
}

# switch namespaces
function kns() {
  local ns=$(_fuzzy-k8s-namespace)
  [ -n "$ns" ] &&
    kubectl config set-context --current --namespace="$ns" 1> /dev/null &&
    echo "Default namespace set to ${ns}"
}

# get yaml for a resource
function kyaml() {
  local res=$(_fuzzy-k8s-all)
  [ -n "$res" ] && kubectl get ${=res} -o yaml "$@"
}

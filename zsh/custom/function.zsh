# GENERAL {{{1
# copy to clipboard
function clipcopy() {
    echo -n "$*" | pbcopy
}

# check if an option is set
function is_set() {
    [[ -o $1 ]] \
        && echo "${fg[green]}$1 is set${reset_color%}" \
        || echo "${fg[red]}$1 is not set${reset_color%}"
}

# redirect stdout from a command to a nvim read only buffer
# mnemonic: vs = v[im]s[pect]
function vs() {
    nvim -MR <<< $("$@")
}

# open suspended vim if it exists or start afresh
function v() {
    fg 2> /dev/null || nvim .
}

# GIT {{{1
# fixup latest commit
function gfix() {
    git commit --fixup "$(git rev-parse HEAD)"
}

# rebase latest commit
function grbh() {
    git rebase -i HEAD~"${1:-1}"
}

# KUBERNETES {{{1
# create a temporary busybox pod
function ktmp() {
    local cmd
    cmd="${*:-sh}"
    kubectl run tmp-"$(date +%s)" --rm -it --image=busybox -- "$cmd"
}

# copy a secret from one namspace to another
function kcsec() {
    local secret namespace_from namespace_to

    if [[ "$#" -lt 3 ]]; then
        read -r "secret?What is the name of the secret? "
        [[ -z "$secret" ]] && echo "Can't be empty" && return 0

        read -r "namespace_from?From which namespace [default]? "
        [[ -z "$namespace_from" ]] && namespace_from="default"

        local current_ns
        current_ns=$(kubectl config view --minify --output "jsonpath={..namespace}")
        read -r "namespace_to?To which namespace [${current_ns}]?"
        [[ -z "$namespace_to" ]] && namespace_to="$current_ns"
    else
        secret="$1"
        namespace_from="$2"
        namespace_to="$3"
    fi

    kubectl get secret "$secret" -n "$namespace_from" -o yaml \
        | sed "s/namespace: ${namespace_from}/namespace: ${namespace_to}/" \
        | kubectl create -f -
}

# scale down all deployments and stateful sets in the current namespace
function kscaledown()
{
    scaleables=$(kubectl get deploy -o name && kubectl get statefulset -o name)
    kubectl scale --replicas 0 ${=scaleables}
}

# scale up all deployments and stateful sets in the current namespace
function kscaleup()
{
    scaleables=$(kubectl get deploy -o name && kubectl get statefulset -o name)
    kubectl scale --replicas 1 ${=scaleables}
}

# FZF {{{1
# GENERAL {{{2
# fzf an alias and paste to command-line
function fza() {
    local sel
    sel="$(alias | fzf | cut -d= -f1)"
    [[ -n "$sel" ]] && print -z -- "$sel"
}

# fza but as a widget to be used with a key binding
function _fuzzy_alias() {
    local sel
    sel="$(alias | fzf | cut -d= -f1)"
    if [[ -n "$sel" ]]; then
        LBUFFER="$sel"
        RBUFFER=''
    fi
    zle reset-prompt
}

zle -N _fuzzy_alias

# fzf in history and paste to command-line
function fzh() {
    local selh
    selh="$(history -1 0 | fzf --query="$@" --ansi --no-sort -m -n 2.. | awk '{sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print;}')"
    [[ -n "$selh" ]] && print -z -- "$selh"
}

# fzh but as a widget to be used with a key binding
function _fuzzy_history() {
    local selh
    selh="$(history -1 0 | fzf --query="$BUFFER" --ansi --no-sort -m -n 2..  | awk '{sub(/^[ ]*[^ ]*[ ]*/, ""); sub(/[ ]*$/, ""); print;}')"
    if [[ -n "$selh" ]]; then
        LBUFFER="$selh"
        RBUFFER=''
    fi
    zle reset-prompt
}

zle -N _fuzzy_history

# like normal z when used with arguments but displays an fzf prompt when used without
unalias z 2> /dev/null
z() {
    [[ $# -gt 0 ]] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --nth 2.. +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# ssh into a host. like normal ssh with arguments, displays a fzf prompt without
function ssh() {
    [[ $# -gt 0 ]] && command ssh "$@" && return
    local host
    host=$(rg "Host (\w+)" ~/.ssh/config -r '$1' | fzf --prompt="SSH Remote > ")
    [[ -n "$host" ]] && command ssh "$host"
}

# copy the current line to the clipboard
function _copy_line_to_clipboard() {
    clipcopy "$BUFFER"
}

zle -N _copy_line_to_clipboard

# copy the contents of a file to the clipboard
function cpf() {
    local file
    [[ "$#" -ge 1 ]] && file="$1" || file=$(fd . --max-depth=1 --type=f | fzf)
    [[ -n "$file" && -f "$file" ]] && pbcopy < "$file" && echo "=> $file copied to the clipboard"
}

# find a project to cd into and activate the conda env

# GIT {{{2
# fzf a commit from git log
function _fuzzy_git_commit() {
    files=$(sed -nE 's/.* -- (.*)/\1/p' <<< "$*")
    preview="echo {} | grep -Eo '[a-f0-9]+' | head -1 | xargs -I% git show --color=always % -- $files"
    git log -n "${1:-20}" --oneline \
        | fzf --preview="$preview" \
        | cut -d' ' -f 1
}

# fzf a commit to fixup
function fzgf() {
    local commit
    commit=$(_fuzzy_git_commit)
    [[ -n "$commit" ]] && git commit --no-verify --fixup "$commit"
}

function _fzgf_widget() { fzgf && zle reset-prompt; }
zle -N _fzgf_widget

# fzf a commit to rebase current branch
# note the use of ~1 in the rebase command as i prefer the flow of including the
# selected commit in the rebase
function fzgr() {
    local commit
    commit=$(_fuzzy_git_commit)
    [[ -n "$commit" ]] && git rebase -i "$commit"~1
}

function _fzgr_widget() { fzgr && zle reset-prompt; }
zle -N _fzgr_widget

# fzf a commit to show
function fzgs() {
    local commit
    commit=$(_fuzzy_git_commit)
    [[ -n "$commit" ]] && git show "$commit"
}

function _fzgs_widget() { fzgs && zle reset-prompt; }
zle -N _fzgs_widget

function _fuzzy_git_branch() {
    local get_branch_command="git branch | grep -v '^*' | awk '{\$1=\$1;print}'"
    eval "${get_branch_command}" \
        | fzf \
            --bind="ctrl-d:execute-silent(git branch -d {})+reload(${get_branch_command})" \
            --header='CTRL-D to delete branch'
}

# fzf a branch
unalias gb 2> /dev/null
function gb() {
    [[ "$#" -ge 1 ]] && git branch "$@" && return 0
    local branch
    branch=$(_fuzzy_git_branch)
    [[ -n "$branch" ]] && git checkout "$branch"
}

# fzf a stash and show diff against head in preview
function _fuzzy_git_stash() {
    git stash list \
        | fzf --preview="echo {} | cut -d: -f1 | xargs git show" \
        | cut -d: -f1
}

# fzf a stash to pop
function fzgsp() {
    local stash
    stash=$(_fuzzy_git_stash)
    [[ -n "$stash" ]] && git stash pop "$stash"
}

function _fzgsp_widget() { fzgsp && zle reset-prompt; }
zle -N _fzgsp_widget

# DOCKER {{{2
# fzf a docker container
function _fuzzy_docker_container() {
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.CreatedAt}}" "$@" \
        | fzf --header-lines=1 --delimiter='\s+' --nth=1,2 \
        | awk '{print $1;}'
}

# drop into a container shell
function dexec() {
    local cid
    cid=$(_fuzzy_docker_container)
    [[ -n "$cid" ]] && docker exec -it "$cid" "${*:-/bin/bash}"
}

# retrieve logs
function dlog() {
    local cid
    cid=$(_fuzzy_docker_container)
    [[ -n "$cid" ]] && docker logs "$@" "$cid"
}

# start a stopped container
function dstart() {
    local cid
    cid=$(_fuzzy_docker_container -f "status=exited")
    [[ -n "$cid" ]] \
        && docker start "$@" "$cid" 1> /dev/null \
        && echo "Container $cid started"
}

# stop a started container
function dstop() {
    local cid
    cid=$(_fuzzy_docker_container)
    [[ -n "$cid" ]] \
        && docker stop "$@" "$cid" 1> /dev/null \
        && echo "Container $cid stopped"
}

# KUBERNETES {{{2
# fzf a pod
function _fuzzy_k8s_pod() {
    kubectl get pods \
        | fzf --header-lines=1 --delimiter='\s+' --nth=1 \
        | awk '{print $1;}'
}

# fzf a container
function _fuzzy_k8s_pod_container() {
    kubectl get pods -o go-template-file="$HOME/.k8s/templates/podlist.gotemplate" \
        | column -t \
        | fzf --header-lines=1 \
        | awk '{print $1,$2;}'
}

# generate a pod + container string for use with kubectl
function _fuzzy_k8s_kubectl_pc() {
    local pc
    pc="$(_fuzzy_k8s_pod_container)"
    [[ -n "$pc" ]] && awk '{print $1,"-c",$2;}' <<< "$pc"
}

# fzf a namespace
function _fuzzy_k8s_namespace() {
    kubectl get namespace |
        fzf --header-lines=1 --delimiter='\s+' --nth=1 |
        awk '{print $1;}'
}

# fzf all
function _fuzzy_k8s_all() {
    kubectl get all -o custom-columns=KIND:.kind,NAME:.metadata.name \
        | fzf --header-lines=1 \
        | awk '{print tolower($1),$2;}'
}

# fzf a context
function _fuzzy_k8s_context() {
    kubectl config get-contexts \
        | fzf --header-lines=1 --delimiter='\s+' --nth=2.. \
        | sed 's/^[\*[:blank:]]*//' \
        | awk '{print $1;}'
}

# retrieve logs for a container
function klog() {
    local pc
    pc=$(_fuzzy_k8s_kubectl_pc)
    [[ -n "$pc" ]] && kubectl logs ${=pc} "$@"
}

# describe a pod
function kdescp() {
    local pod
    pod=$(_fuzzy_k8s_pod)
    [[ -n "$pod" ]] && kubectl describe pod "$pod" "$@"
}

# describe a resource
function kdesc() {
    local res
    res=$(_fuzzy_k8s_all)
    [[ -n "$res" ]] && kubectl describe ${=res} "$@"
}

# drop into a container shell
function kexec() {
    local pc
    pc=$(_fuzzy_k8s_kubectl_pc)
    [[ -n "$pc" ]] && kubectl exec -it ${=pc} -- "${*:-/bin/bash}"
}

# switch namespaces
# use with argument to switch to given ns
# use without argument to pick from a menu
function kns() {
    local ns
    [[ "$#" -ge 1 ]] && ns="$1" || ns=$(_fuzzy_k8s_namespace)
    [[ -n "$ns" ]] \
        && kubectl config set-context --current --namespace="$ns" 1> /dev/null \
        && echo "Default namespace set to ${ns}"
}

# get yaml for a resource
function kyaml() {
    local res
    res=$(_fuzzy_k8s_all)
    [[ -n "$res" ]] && kubectl get ${=res} -o yaml "$@"
}

# switch context
function kctx() {
    local ctx
    ctx=$(_fuzzy_k8s_context)
    [[ -n "$ctx" ]] && kubectl config use-context "$ctx"
}

# HELM {{{2
# fzf a chart
function _fuzzy_helm_chart() {
    helm list "$@" \
        | fzf --header-lines=1 --delimiter='\s+' --nth=1,2,6 \
        | awk '{print $1;}'
}

# uninstall a chart
function hun() {
    local chart
    chart=$(_fuzzy_helm_chart)
    [[ -n "$chart" ]] && helm uninstall "$chart"
}

# GIT {{{1
function fixup() {
  local current_sha="$(git rev-parse HEAD)"

  git commit --fixup $current_sha
}

function rhead() {
  git rebase -i HEAD~$1
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
# fzf a docker container to drop into
function dexec() {
  docker ps --format "{{.Names}}" | fzf | xargs -o -I% docker exec -it % /bin/bash
}

# fzf a docker container to retrieve logs
function dlog() {
  docker ps --format "{{.Names}}" | fzf | xargs docker logs
}

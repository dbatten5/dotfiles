# GIT {{{1
function fixup() {
  local current_sha="$(git rev-parse HEAD)"

  git commit --fixup $current_sha
}

function rhead() {
  git rebase -i HEAD~$1
}

# DOCKER {{{1
function dexec() {
  docker exec -it $1 /bin/bash
}

# FZF {{{1
# ALIASES {{{2
# fuzzy find an alias and paste to command-line
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

# GIT {{{2
# fuzzy find a commit to fixup
function fzgf() {
  git log -n ${1:-20} --oneline | fzf | cut -d' ' -f 1 | xargs git commit --no-verify --fixup
}

zle -N fzgf
bindkey -M viins '^g^f' fzgf

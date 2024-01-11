export FZF_DEFAULT_OPTS="
  --height=40%
  --min-height=25
  --info=inline
  --preview-window='right:60%'
  --layout=reverse
  --bind='ctrl-d:half-page-down'
  --bind='ctrl-u:half-page-up'
  --bind='ctrl-a:select-all+accept'
  --bind='ctrl-y:execute-silent(echo {+} | pbcopy)'
  --bind='?:toggle-preview'
  --bind='ctrl-e:execute(echo {+} | xargs -o nvim)'
  --bind='ctrl-x:unix-line-discard'
"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules'"

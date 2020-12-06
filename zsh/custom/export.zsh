export PATH="/usr/local/opt/libxml2/bin:$PATH"

export PATH=$PATH:/usr/local/sbin

export PATH="$HOME/.local/bin:$PATH"

export CC=gcc
export CXX=clang

export PATH="$HOME/.poetry/bin:$PATH"

export NVIMCONFIG="$HOME/.config/nvim"

export KUBE_EDITOR="nvim"

export BAT_THEME="base16"

export FZF_DEFAULT_OPTS="
  --height=40%
  --min-height=25
  --info=inline
  --preview-window=':hidden'
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

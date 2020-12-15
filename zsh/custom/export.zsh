export PATH=$PATH:/usr/local/sbin
export PATH="$HOME/.local/bin:$PATH"

# set path to nvim config for various utilities
export NVIMCONFIG="$HOME/.config/nvim"

# edit k8s resources in nvim
export KUBE_EDITOR="nvim"

export BAT_THEME="base16"

# set fzf defaults
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

# use nvim for man pages
export MANPAGER="col -b | nvim -MR - "

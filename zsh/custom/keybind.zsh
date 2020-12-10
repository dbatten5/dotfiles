bindkey -v

bindkey '^e' end-of-line
bindkey '^a' beginning-of-line
bindkey '^b' backward-word
bindkey '^w' forward-word
bindkey '^h' backward-char
bindkey '^l' forward-char
bindkey '^d' kill-word
bindkey '^k' vi-kill-eol
bindkey '^u' kill-whole-line
bindkey '^p' history-beginning-search-backward
bindkey '^o' history-beginning-search-backward

# custom
bindkey -M viins '^f^a' _fuzzy-alias
bindkey -M viins '^r' _fuzzy-history
bindkey -M viins '^g^f' fzgf
bindkey -M viins '^g^r' fzgr

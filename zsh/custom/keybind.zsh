# use vim bindings
bindkey -v

# bindings with builtins
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
bindkey '^o' history-beginning-search-forward

# bindings with custom functions
bindkey -M viins '^f^a' _fuzzy_alias
bindkey -M viins '^r' _fuzzy_history
bindkey -M viins '^y' _copy_line_to_clipboard
bindkey -M viins '^g^f' _fzgf_widget
bindkey -M viins '^g^r' _fzgr_widget
bindkey -M viins '^g^s' _fzgs_widget

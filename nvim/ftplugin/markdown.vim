"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable spellchecking for markdown files and git commit messages
autocmd vimrc FileType markdown,gitcommit setlocal spell
setlocal nowrap
setlocal nolinebreak
setlocal formatoptions-=t
setlocal textwidth=0
setlocal wrapmargin=0
" Set indentation to 2 for .md files
autocmd vimrc FileType markdown setlocal sw=2 sts=2 ts=2

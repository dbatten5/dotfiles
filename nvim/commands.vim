"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrc
    autocmd!
augroup END

" Remove cursorline highlight
autocmd vimrc InsertEnter,BufLeave * :set nocul
" Add cursorline highlight
autocmd vimrc InsertLeave,BufEnter * :set cul
" Refresh file when vim gets focus
autocmd vimrc FocusGained,BufEnter * checktime
" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd vimrc BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

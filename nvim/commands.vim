" GENERAL {{{1
augroup vimrc
  autocmd!
" Remove cursorline highlight
  autocmd InsertEnter,BufLeave * :set nocul
  " Add cursorline highlight
  autocmd InsertLeave,BufEnter * :set cul
  " Refresh file when vim gets focus
  autocmd FocusGained,BufEnter * checktime
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif
augroup END

" COLOUR {{{1
augroup nord_theme_overrides
  autocmd!
  autocmd ColorScheme nord highlight jsxTagName ctermfg=14 guifg=#5E81AC
  " autocmd ColorScheme nord highlight SpecialKey ctermfg=6 guifg=#88C0D0
  autocmd ColorScheme nord highlight ExtraWhitespace guifg=#88C0D0
  autocmd ColorScheme nord match ExtraWhiteSpace /\s\+$/
augroup END

" SPELUNKER {{{1
augroup spelunker_filetype_switch
  autocmd!
  autocmd FileType git let b:enable_spelunker_vim = 0
  autocmd BufNewFile,BufRead *.lock let b:enable_spelunker_vim = 0
augroup END

" PENCIL {{{1
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,text call pencil#init()
augroup END

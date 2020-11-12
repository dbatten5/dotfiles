function! general#StripTrailingWhiteSpaces()
  if &modifiable
    let l:l = line(".")
    let l:c = col(".")
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif
endfunction

function! general#OpenTerminal()
    :vnew
    :terminal
    :startinsert
endf

function! general#OpenSnippets()
    let l:path = "~/.config/nvim/my-snippets/Ultisnips/" . &filetype . ".snippets"
    exec "vsp " . l:path
endfunction

function! general#OpenFTPlugin()
    let l:path = "~/.config/nvim/ftplugin/" . &filetype . ".vim"
    exec "vsp " . l:path
endfunction

function! general#OpenNote()
    let path = "~/Documents/notes/" . &filetype . ".md"
    exec "vsp " . path
endfunction

function! general#StripTrailingWhiteSpaces()
  if &modifiable
    let l:l = line('.')
    let l:c = col('.')
    %s/\s\+$//e
    call cursor(l:l, l:c)
  endif
endfunction

function! general#OpenTerminal()
  execute 'vnew' | execute 'terminal' | execute 'startinsert'
endf

function! general#OpenFTPlugin()
  let path = '~/.config/nvim/ftplugin/' . &filetype . '.vim'
  execute 'vsp ' . l:path
endfunction

function! general#OpenNote()
  let path = '~/Documents/notes/' . &filetype . '.md'
  execute 'vsp ' . path
endfunction

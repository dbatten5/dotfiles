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

function! general#Google(pat, lucky)
  let q = '"'.substitute(a:pat, '["\n]', ' ', 'g').'"'
  let q = substitute(q, '[[:punct:] ]',
       \ '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
  call system(printf('open "https://www.google.com/search?%sq=%s"',
                   \ a:lucky ? 'btnI&' : '', q))
endfunction

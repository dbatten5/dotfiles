"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> <buffer> I :call CreateDirectory()<CR>
nnoremap <silent> <buffer> i :call CreateFile()<CR>
nmap <silent> <buffer> cc :call RenameItemUnderCursor()<CR>
nnoremap <silent> <buffer> dd :call DeleteItemUnderCursor()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2
set shiftwidth=2
set expandtab

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check yaml files with yamllint
let b:ale_linters = {'yaml': ['yamllint']}

augroup ffs_yaml | au!
  autocmd BufEnter *
    \ if search('^apiVersion', 'nw')
      \ | let b:ffs_scope = 'kubernetes'
    \ | endif
augroup end

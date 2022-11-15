"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
" Wrap text at 88 characters
set textwidth=88
set colorcolumn=88
" This is used for CursorHold event, used by ALE to display symbol information
" in the message window. Default is 4000 which is a bit too long for me
set updatetime=2000

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <space>b :!black %<cr>
noremap <space>i :!isort %<cr>
noremap <space>u :!autoimport %<cr>
noremap <space>x :Dispatch python %
noremap <space>X :Dispatch python %<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let b:ale_linters = {'python': ['pylint', 'flake8', 'mypy', 'pyright']}
let b:ale_fixers = {'python': ['autoimport', 'isort', 'black']}
let b:ale_python_autoimport_executable = '/usr/local/bin/autoimport'
let b:ale_python_black_executable = '/usr/local/bin/black'
let b:ale_python_isort_executable = '/usr/local/bin/isort'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-TEST
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#python#runner = 'pytest'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DOGE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:doge_doc_standard_python = 'google'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup ffs_py | au!
  " set FFS scope for pytest files
  autocmd BufEnter test_*.py let b:ffs_scope = 'pytest'
augroup end

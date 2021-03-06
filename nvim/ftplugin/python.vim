"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nowrap
" Wrap text at 88 characters
set textwidth=88
set colorcolumn=88

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <space>b :!black %<cr>
noremap <space>i :!isort %<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Check Python files with flake8 and pylint.
let b:ale_linters = {'python': ['pylint', 'flake8']}
" Fix Python files with black and isort.
let b:ale_fixers = {'python': ['black', 'isort']}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-TEST
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#python#runner = 'pytest'

augroup ffs_py | au!
  autocmd BufEnter test_*.py let b:ffs_scope = 'pytest'
augroup end

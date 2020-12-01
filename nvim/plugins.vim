" PLUGINS {{{1

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'FooSoft/vim-argwrap'
Plug 'SirVer/ultisnips'
Plug 'arcticicestudio/nord-vim'
Plug 'chaoren/vim-wordmotion'
Plug 'dbakker/vim-projectroot'
Plug 'dense-analysis/ale'
Plug 'janko-m/vim-test'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'ludovicchabant/vim-gutentags'
Plug 'maxmellon/vim-jsx-pretty', {'for': 'javascipt'}
Plug 'pangloss/vim-javascript', {'for': 'javascipt'}
Plug 'preservim/tagbar'
Plug 'radenling/vim-dispatch-neovim'
Plug 'sodapopcan/vim-twiggy'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'wellle/targets.vim'

Plug '~/projects/personal/vim-scranch'
Plug '~/projects/personal/vim-macroscope'
call plug#end()

" VIM TEST {{{1
let test#strategy = {
  \ 'nearest': 'neovim',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch',
\}
nnoremap <silent> <leader>tf :TestNearest<cr>
nnoremap <silent> <leader>td :TestNearest -strategy=dispatch<cr>
nnoremap <silent> <leader>tt :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>

" VIM FUGITIVE {{{1
nnoremap <space>gs :belowright :20Gstatus<cr>
nnoremap <space>gd :Gdiff<cr>
nnoremap <space>ge :Gblame<cr>
nnoremap <space>grb :Git rebase -i<space>
nnoremap <space>grc :Git rebase --continue<cr>
nnoremap <space>grm :Git rebase -i origin/master<cr>
nnoremap <space>gb :Git branch<space>
nnoremap <space>gc :Git checkout<space>
nnoremap <space>gp :Gpush origin HEAD<cr>
nnoremap <space>gl :Git pull<cr>
" merge conflict resolution
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

" MERGINAL {{{1
" let g:merginal_splitType=''
" let g:merginal_windowSize='15'
" nnoremap <space>gb :Merginal<cr>

" TWIGGY {{{1
let g:twiggy_group_locals_by_slash = 0
let g:twiggy_local_branch_sort = 'mru'
let g:twiggy_remote_branch_sort = 'date'
let g:twiggy_close_on_fugitive_command = 1
let g:twiggy_split_position = 'topleft'
let g:twiggy_num_columns = 40
nnoremap <space>gb :Twiggy<cr>

" ALE {{{1
" Only lint when saving or entering a file
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 1
nnoremap <leader>af :ALEFix<cr>

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" VIM COMMENTARY {{{1
" Comment map
nmap <leader>c gcc
" Line comment command
xmap <leader>c gc

" VIM ARG WRAP {{{1
let g:argwrap_padded_braces = '[{'
let g:argwrap_tail_comma = 1
nnoremap <silent> <leader>aw :ArgWrap<CR>

" FZF {{{1
command! -bang -nargs=? -complete=dir Ag
    \ call fzf#vim#ag(<q-args>, 
    \ {'options': '--exact --delimiter : --nth 4..'}, 
    \ <bang>0)
:nnoremap <c-f> :GFiles<cr>
:nnoremap \ :Ag<cr>
:nnoremap <leader>f* :Ag <c-r><c-w><cr>
:nnoremap <c-b> :Buffers<cr>
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.7, 'highlight': 'Operator', 'border': 'sharp' } }

" ULTI SNIPS {{{1
let g:UltiSnipsSnippetDirectories=['my_snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'
let g:UltiSnipsEditSplit='vertical'
nnoremap <leader>os :UltiSnipsEdit<cr>

" AUTOPAIRS {{{1
" Remove the <c-h> mapping due to conflict with my imode movement bindings
let g:AutoPairsMapCh=0

" NORD {{{1
let g:nord_uniform_diff_background=1

" SCRANCH {{{1
let g:scranch_directory = '~/scranch'
nnoremap gs :Scranch!<cr>
nnoremap gS :Scranch<cr>
nnoremap ga :ScranchPreview<cr>

" GUTENTAGS {{{1
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.json', '*.xml',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*/test*', '*vendor/*/Test*',
                            \ '*vendor/*/fixture*', '*vendor/*/Fixture*',
                            \ '*var/cache*', '*var/log*', '*node_modules*',
                            \ '*bundle*']
let g:gutentags_cache_dir = '~/.tags'

" DIRVISH {{{1
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
noremap <silent> <c-e> :Dirvish %<cr>
noremap <silent> <c-s> :Dirvish<cr>

" TAGBAR {{{1
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_position = 'topleft vertical'
let g:tagbar_compact = 1

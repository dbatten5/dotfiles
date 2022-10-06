" PLUGINS {{{1

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'FooSoft/vim-argwrap'
Plug 'SirVer/ultisnips'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'andrewradev/deleft.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'chaoren/vim-wordmotion'
Plug 'dbakker/vim-projectroot'
Plug 'dense-analysis/ale'
" Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'janko-m/vim-test'
Plug 'jeetsukumaran/vim-pythonsense', {'for': 'python'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'kamykn/spelunker.vim'
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
Plug 'ludovicchabant/vim-gutentags'
Plug 'maxmellon/vim-jsx-pretty', {'for': 'javascript'}
Plug 'mbbill/undotree'
" Plug 'metakirby5/codi.vim'
Plug 'mickael-menu/zk-nvim'
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'preservim/tagbar'
Plug 'radenling/vim-dispatch-neovim'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-python/python-syntax', {'for': 'python'}
" Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'
Plug 'yegappan/mru'
Plug 'Yggdroot/indentLine'

Plug '~/projects/personal/vim-ffs'
Plug '~/projects/personal/vim-macroscope'
Plug '~/projects/personal/vim-scranch'
call plug#end()

" VIM TEST {{{1
let test#strategy = {
  \ 'nearest': 'dispatch',
  \ 'file':    'dispatch',
  \ 'suite':   'dispatch',
\}
nnoremap <silent> <leader>tf :TestNearest<cr>
nnoremap <silent> <leader>tl :TestLast<cr>
nnoremap <silent> <leader>td :TestNearest -strategy=dispatch<cr>
nnoremap <silent> <leader>tt :TestFile<cr>
nnoremap <silent> <leader>ts :TestSuite<cr>

" FUGITIVE {{{1
nnoremap <space>gs :Git<cr>
nnoremap <space>gg :Git log<cr>
nnoremap <space>ge :Git blame<cr>
nnoremap <space>gb :Git branch<space>
nnoremap <space>gc :Git checkout<space>
nnoremap <space>gC :Git commit --no-verify<cr>
nnoremap <space>gp :Git push origin HEAD<cr>
nnoremap <space>gP :Git push origin HEAD --force-with-lease<cr>
nnoremap <space>gl :Git pull<cr>
nnoremap <space>gm :Git pull origin master<cr>
nnoremap <space>gw :Git show<cr>
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
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
nnoremap <space>af :ALEFix<cr>
nnoremap <space>al :ALELint<cr>
nnoremap <space>an :ALENextWrap<cr>
nnoremap <space>ap :ALEPreviousWrap<cr>
nnoremap <space>ad :ALEDetail<cr>
nnoremap <space>ar :ALERename<cr>
nnoremap <space>ah :ALEHover<cr>
nnoremap <space>ai :ALEInfo<cr>
nnoremap <space>aa :ALE
inoremap <c-a> <c-\><c-o>:ALEComplete<cr>

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
let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.7, 'highlight': 'Operator', 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS="--preview-window 'right:60%' --layout default --margin=1,4 --bind='ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-a:select-all+accept,ctrl-x:unix-line-discard'"
command! -bang -nargs=? -complete=dir Ag
    \ call fzf#vim#ag(<q-args>, 
    \ {'options': '--exact --delimiter : --nth 4..'}, 
    \ <bang>0)
nnoremap <c-f> :GFiles<cr>
nnoremap \ :Ag<cr>
nnoremap <leader>f* :Ag <c-r><c-w><cr>
nnoremap <c-b> :Buffers<cr>
" fzf a note and open it 
command! Notes call fzf#run(fzf#wrap({
      \ 'source': 'ls',
      \ 'dir': '~/Documents/notes',
      \ 'sink': 'e',
      \ 'options': ['--preview', 'bat {}', '--prompt', 'Notes>', '-m'],
      \ }))
nnoremap gn :Notes<cr>
command! Projects call fzf#run(fzf#wrap({
      \ 'source': 'fd --max-depth=2 .',
      \ 'dir': '~/projects',
      \ 'sink': 'vsplit',
      \ }))
nnoremap gp :Projects<cr>

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
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']
let g:gutentags_cache_dir = '~/.tags'

" DIRVISH {{{1
let g:dirvish_mode = ':sort | sort ,^.*[^/]$, r'
noremap <silent> <c-e> :Dirvish %<cr>

" TAGBAR {{{1
nnoremap <F8> :TagbarToggle<CR>
let g:tagbar_position = 'topleft vertical'
let g:tagbar_compact = 1

" COC {{{1
" inoremap <silent><expr> <c-space> coc#refresh()

" FFS {{{1
let g:ffs_schema = {
      \ 'sh': 'bash',
      \ }
nnoremap <c-s> :FFS<space>

" MARKDOWN PREVIEW {{{1
let g:mkdp_auto_close = 0

" PYTHON SYNTAX {{{1
let g:python_highlight_all = 1

" SPELUNKER {{{1
let g:spelunker_check_type = 2

" UNDOTREE {{{1
nnoremap <F5> :UndotreeToggle<cr>

" MRU {{{1
nnoremap <space>m :MRU<cr>
let MRU_Filename_Format = {
\ 'formatter': "fnamemodify(v:val, ':p:t') .. ' (' .. fnamemodify(v:val, ':p:~') .. ')'",
\ 'parser':'(\zs.*\ze)',
\ 'syntax': '^.\{-}\ze('}

" DOGE {{{1
let g:doge_mapping_comment_jump_forward = ']'
let g:doge_mapping_comment_jump_backward = '['

" CODI {{{1
" nnoremap <space>ci :Codi<cr>
" nnoremap <space>cc :Codi!<cr>
" nnoremap <space>cn :CodiNew<cr>>
" nnoremap <space>ce :CodiExpand<cr>

" MAGMA {{{1
nnoremap <silent><expr> <space>r  :MagmaEvaluateOperator<CR>
nnoremap <silent>       <space>rr :MagmaEvaluateLine<CR>
xnoremap <silent>       <space>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       <space>rc :MagmaReevaluateCell<CR>
nnoremap <silent>       <space>rd :MagmaDelete<CR>
nnoremap <silent>       <space>ro :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"

" VIMWIKI {{{1
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_table_mappings = 0

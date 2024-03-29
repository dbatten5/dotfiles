" A minimal vimrc to get me started on a new machine

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on syntax highlighting
syntax on

" Enable plugins and indents by filetype
filetype plugin indent on

" Change leader to comma
let g:mapleader=','

" Highlight the current line
set cursorline
" Show line numbers
set number
" Show line numbers relative to the current line
set relativenumber
" Store lots of command line history
set history=100
" Smart case search if there is a uppercase
set ignorecase smartcase
" Highlight the matching bracket
set showmatch
" Jump to the first non-blank character of the line
set nostartofline
" Enable word wrap
set wrap
" Wrap lines at convenient points
set linebreak
" Display extra whitespace
set list listchars=tab:\ \ ,trail:·,nbsp:·
" Do not redraw on registers and macros
set lazyredraw
" Hide buffers in the background
set hidden
" Set new vertical splits to the right
set splitright
" Set new horizontal splits to the below
set splitbelow
" Wrap text at 80 characters
set textwidth=80
" Turn off that bell noise
set noerrorbells
" Incremental searching
set incsearch
set nohlsearch
" Set column gutter width
set numberwidth=3

" Turn off swap files
set noswapfile
set nobackup
set nowritebackup

" Indentation
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set autoindent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEYMAPS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make <c-c> the same as esc in insert mode
inoremap <c-c> <esc>

" Quicker window movement
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Remap the hash key as it's awkward on a mac
nnoremap & #

" Swap ' and ` for going to marks
nnoremap ' `
nnoremap ` '

" Exchange J and j in visual mode because I keep pressing it in my haste when I
" go into visual block / line mode and want to immediately move down a line
vnoremap J j

" Do the same for K and k
vnoremap K k

" Swap 0 and ^ as ^ is more useful but more keystrokes to get to
nnoremap 0 ^
nnoremap ^ 0

" Swap v and ctrl-v as visual block mode is more useful
nnoremap v <c-v>
nnoremap <c-v> v
vnoremap v <c-v>
vnoremap <c-v> v

" Indent without killing the selection in vmode
vnoremap < <gv
vnoremap > >gv

" Paste last yanked item
noremap <space>p "0p
noremap <space>P "0P

" Quicker saves
nnoremap <silent> s :update<cr>


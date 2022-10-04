" COLOUR {{{1
colorscheme nord
if has('termguicolors')
    set termguicolors
endif

" BASIC EDITING CONFIGURATION {{{1
" Enable plugins and indents by filetype
filetype plugin indent on

" Change leader to comma
let g:mapleader = ','

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
" Highlight the matching the matching bracket
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
" Allow recursive search
set path+=**
" Wrap text at 80 characters
set textwidth=80
" Turn off that bell noise
set noerrorbells
" Incremental searching
set incsearch
set nohlsearch
" Set column gutter width
set numberwidth=3

" Turn on syntax highlighting
syntax on

" Turn off swap files
set noswapfile
set nobackup
set nowb

" Persistent undo
silent !mkdir ~/.config/nvim/backups > /dev/null 2>&1
set undodir=~/.config/nvim/backups
set undofile

" Indentation
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smartindent
set autoindent
set colorcolumn=80

" Folding
" set nofoldenable

" Start scrolling when 8 lines away from margins
set scrolloff=4
set sidescrolloff=15
set sidescroll=5

" Make sure git diff opens a vertical buffer
set diffopt=vertical

" Set python host to machine rather than any virtual envs
let g:python_host_prog='/usr/bin/python'
let g:python3_host_prog='/usr/bin/python3'

" Keep the cursor on the same column
set nostartofline

" COMPLETION {{{1
" Things to ignore when searching
set wildmode=list:full
set wildignore=*.git*
set wildignore+=*/vendor/**
set wildignore+=*/node_modules/**
set wildignore+=*/public/**
set wildignore+=*/venv/**

" STATUSLINE {{{1
hi User1 guifg=#FF0000 guibg=#2C323C
" Mode
set statusline=\ %{toupper(mode())}
" Git branch
set statusline+=\ %{FugitiveHead()}
" File path
set statusline+=\ %4F
" Modified indicator
set statusline+=\ %1*%m%*
" Preview indicator
set statusline+=\ %w
" Quickfix list indicator
set statusline+=\ %q
" Start right side layout
set statusline+=\ %=
" Filetype
set statusline+=\ %y
" Percentage
set statusline+=\ %p%%
" Current line number/Total line numbers
set statusline+=\ %l/%L
" Errors count
set statusline+=\ %1*%{LinterStatus()}%*

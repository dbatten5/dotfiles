" Init

" remove all existing autocmds
autocmd!

" Change leader to comma
let g:mapleader = ','

source $HOME/.config/nvim/functions.vim
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/keymap.vim
source $HOME/.config/nvim/config.vim

lua require('config')

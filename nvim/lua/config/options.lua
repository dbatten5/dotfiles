-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------

local g = vim.g
local opt = vim.opt

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.completeopt = 'menuone,noinsert,noselect'
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.colorcolumn = '80'

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.termguicolors = true
vim.cmd.colorscheme('nord')

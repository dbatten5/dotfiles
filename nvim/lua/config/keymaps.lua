-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------
map('n', 's', ':update<CR>')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')
map('n', 's', ':w<CR>')
map({'n', 'x'}, 'gy', '"+y')
map({'n', 'x'}, 'gp', '"+p')
map({'n', 'x'}, 'x', '"_x')
map({'n', 'x'}, 'X', '"_d')
map('n', '<leader>a', ':keepjumps normal! ggVG<cr>')

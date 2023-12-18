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

map('n', '<leader>ev', '<cmd>vnew $NVIMCONFIG<cr>')
map('n', '<c-e>', '<cmd>e .<cr>')
map('n', 's', '<cmd>update<CR>') -- quick saves
-- window movement
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-l>', '<c-w>l')
-- copy/paste from system clip
map({'n', 'x'}, 'gy', '"+y')
map({'n', 'x'}, 'gp', '"+p')
map('i', '<c-v>', '"+p')
-- delete without copying to register
map({'n', 'x'}, 'x', '"_x')
map({'n', 'x'}, 'X', '"_d')
map('n', '<leader>a', '<cmd>keepjumps normal! ggVG<cr>') -- highlight all text
-- swap ' and `
map('n', '\'', '`')
map('n', '`', '\'')
map('v', 'J', 'j') -- swap J and j in visual mode
map('v', 'K', 'k') -- swap K and k in visual mode
-- indent without killing selection
map('v', '<', '<gv')
map('v', '>', '>gv')
-- swap v and ctrl-v as visual block mode is more useful
map('n', 'v', '<c-v>')
map('n', '<c-v>', 'v')
map('v', 'v', '<c-v>')
map('v', '<c-v>', 'v')
-- map('n', '<leader>fc' "/\v^[<\|=>]{7}( .*\|$)<cr>") -- find merge conflicts
-- swap 0 and ^
map('n', '0', '^')
map('n', '^', '0')
-- movement in insert mode
map('i', '<c->h', '<c-o>h')
map('i', '<c->l', '<c-o>l')
map('i', '<c->j', '<c-o>j')
map('i', '<c->k', '<c-o>k')
-- paste last yanked item
map('n', '<space>p>', '"0p')
map('n', '<space>P>', '"0P')
map('n', 'Q', '@q') -- i don't use ex mode
-- map('i', '<c-i>' '<c-g>u<Esc>[s1z=`]a<c-g>u') -- correct spelling
map('v', 's', '<cmd>s/') -- visual mode substitute
map('n', '<space>o', '<cmd>!open .<cr>') -- open file in finder

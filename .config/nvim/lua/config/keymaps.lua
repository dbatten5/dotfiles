-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

map("n", "s", "<cmd>update<CR>") -- quick saves
-- window movement
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")
-- copy/pate from system clip
map({ "n", "x" }, "gy", '"+y')
map({ "n", "x" }, "gp", '"+p')
map("i", "<c-v>", '"+p')
-- -- delete without copying to register
-- map({'n', 'x'}, 'x', '"_x')
-- map({'n', 'x'}, 'X', '"_d')
map("n", "<space>a", "<cmd>keepjumps normal! ggVG<cr>") -- highlight all text
-- swap ' and `
map("n", "'", "`")
map("n", "`", "'")
map("n", "&", "#") -- move # (oppsite of *), closer to *
map("v", "J", ":m '>+1<cr>gv=gv") -- move chunks of text up
map("v", "K", ":m '<-2<cr>gv=gv") -- move chunks of text down
-- keeping the cursor in nice places
map("n", "J", "mzJ`z")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "<c-d>", "<c-d>zz")
map("n", "<c-u>", "<c-u>zz")
-- indent without killing selection
map("v", "<", "<gv")
map("v", ">", ">gv")
-- swap v and ctrl-v as visual block mode is more useful
map("n", "v", "<c-v>")
map("n", "<c-v>", "v")
map("v", "v", "<c-v>")
map("v", "<c-v>", "v")
-- swap 0 and ^
map("n", "0", "^")
map("n", "^", "0")
-- paste last yanked item
map("n", "<space>p>", '"0p')
map("n", "<space>P>", '"0P')
map("n", "Q", "@q") -- i don't use ex mode
-- map('i', '<c-i>' '<c-g>u<Esc>[s1z=`]a<c-g>u') -- correct spelling
map("n", "<space>o", "<cmd>!open .<cr>") -- open file in finder
-- quickfix
map("n", "<leader>qf", "<cmd>copen<cr>")
map("n", "<leader>qo", "<cmd>colder<cr>")
map("n", "<leader>qn", "<cmd>cnewer<cr>")

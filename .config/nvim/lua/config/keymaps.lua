local map = require("utils.functions").setKeymap
local swap = require("utils.functions").swapKeymaps

-----------------------------------------------------------
-- Define keymaps of native Neovim
-----------------------------------------------------------

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
--
map("n", "<space>a", "<cmd>keepjumps normal! ggVG<cr>") -- highlight all text

-- swap ' and `
swap("'", "`")

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
swap("v", "<c-v>")
swap("v", "<c-v>", "v")

-- swap 0 and ^
swap("0", "^")

-- paste last yanked item
map("n", "<space>p>", '"0p')
map("n", "<space>P>", '"0P')

map("n", "Q", "@q") -- run macro for q register on big Q (I don't use ex mode)

map("n", "<space>O", "<cmd>!open .<cr>") -- open cwd in finder
map("n", "<space>o", "<cmd>!open %:h<cr>") -- open directory of current file in finder

-- quickfix
map("n", "<leader>qf", "<cmd>copen<cr>")
map("n", "<leader>qo", "<cmd>colder<cr>")
map("n", "<leader>qn", "<cmd>cnewer<cr>")

-- insert mode movement
map("i", "<c-l>", "<right>")
map("i", "<c-h>", "<left>")

-- diagnostics
map("n", "<space>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

map("n", "<leader>yf", function()
  require("utils.functions").copyCurrentFileToSystemClipboard()
end) -- copy current file to system clipboard

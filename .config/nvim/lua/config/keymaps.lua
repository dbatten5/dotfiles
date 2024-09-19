local utils = require("utils.functions")
local map = utils.setKeymap
local swap = utils.swapKeymaps

-----------------------------------------------------------
-- Define keymaps of native Neovim
-----------------------------------------------------------

-- quick saves
map("n", "s", "<cmd>update<CR>")

-- window movement
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")

-- copy/pate from system clip
map({ "n", "x" }, "gy", '"+y')
map({ "n", "x" }, "gp", '"+p')
map("i", "<c-v>", '"+p')
map("n", "<c-s-s>", function()
  local fileContents = vim.fn.join(vim.fn.readfile(vim.fn.expand("%")), "\n")
  utils.copyToSystemClipboard(fileContents)
  vim.notify("Current file contents copied to system clipboard", vim.log.levels.INFO)
end, { desc = "Copy file contents to system clipboard" })

-- highlight all text
map("n", "<space>a", "<cmd>keepjumps normal! ggVG<cr>", { desc = "Highlight all text" })

-- ` is more useful than ' for going to marks but it's more awkward to reach
swap("'", "`")

-- move # (oppsite of *), closer to *
swap("&", "#")

-- move chunks of text up or down
map("v", "J", ":m '>+1<cr>gv=gv") -- up
map("v", "K", ":m '<-2<cr>gv=gv") -- down

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

-- ^ is more useful than 0 but it's more keystrokes to get it
swap("0", "^")

-- paste last yanked item
map("n", "<space>p>", '"0p')
map("n", "<space>P>", '"0P')

-- run macro for q register on big Q (I don't use ex mode)
map("n", "Q", "@q")

-- opening stuff in finder
map("n", "<space>O", "<cmd>!open .<cr>", { desc = "Open cwd in finder" })
map("n", "<space>o", "<cmd>!open %:h<cr>", { desc = "Open directory of current file in finder" })

-- quickfix
map("n", "<leader>qf", "<cmd>copen<cr>", { desc = "Open quickfix" })
map("n", "<leader>qo", "<cmd>colder<cr>", { desc = "Go to older quickfix" })
map("n", "<leader>qn", "<cmd>cnewer<cr>", { desc = "Go to newer quickfix" })

-- insert mode movement
map("i", "<c-l>", "<right>")
map("i", "<c-h>", "<left>")

-- diagnostics
map("n", "<space>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

map("n", "<leader>yf", function()
  local fp = vim.fn.expand("%:.:r")
  utils.copyToSystemClipboard(fp)
  vim.notify("Current filepath copied to system clipboard", vim.log.levels.INFO)
end, { desc = "Copy current filepath to system clipboard" })

map("n", "<leader>yw", function()
  local word = vim.fn.expand("<cword>")
  utils.copyToSystemClipboard(word)
  vim.notify(word .. " copied to system clipboard", vim.log.levels.INFO)
end, { desc = "Copy word under the cursor to system clipboard" })

map("n", "<leader>gf", function()
  local fp = vim.fn.expand("%:.")
  local lineNumber = vim.api.nvim_win_get_cursor(0)[1]
  local path = fp .. ":" .. lineNumber
  vim.fn.system("gh browse " .. path)
end, { desc = "Open the current file in GitHub" })

local map = require("utils.functions").setKeymap

vim.opt.textwidth = 120
vim.opt.colorcolumn = "120"

map("n", "<space>x", "<cmd>source %<cr>", { desc = "Execute the current file" })
map("n", "<space><space>x", "<cmd>.lua<cr>", { desc = "Execute the current line" })

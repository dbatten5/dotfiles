local map = require("utils.functions").setKeymap

vim.opt_local.textwidth = 88
vim.opt_local.colorcolumn = "88"

map("n", "<space>x", "<cmd>source %<cr>", { desc = "Execute the current file" })
map("n", "<space><space>x", "<cmd>.lua<cr>", { desc = "Execute the current line" })

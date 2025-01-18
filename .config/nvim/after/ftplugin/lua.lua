local map = require("utils.functions").setKeymap

vim.opt.textwidth = 88
vim.opt.colorcolumn = "88"

map("n", "<space>x", "<cmd>source %<cr>", { desc = "Execute the current file" })
map("n", "<space><space>x", "<cmd>.lua<cr>", { desc = "Execute the current line" })

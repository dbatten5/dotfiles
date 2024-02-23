local map = require("utils.functions").setKeymap

local getImportPath = function()
  return string.gsub(vim.fn.expand("%:r"), "/", ".")
end

vim.opt.colorcolumn = "88"

map("n", "<leader>pp", function()
  local import_path = getImportPath()
  vim.api.nvim_put({ import_path }, "c", true, true)
end, { desc = "Paste the Python import path of the current file" })

map("n", "<leader>yp", function()
  local import_path = getImportPath()
  vim.fn.setreg("+", import_path)
end, { desc = "Copy the Python import path of the current file to the system clipboard" })

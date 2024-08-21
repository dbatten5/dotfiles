local map = require("utils.functions").setKeymap

local getImportPath = function()
  return string.gsub(vim.fn.expand("%:.:r"), "/", ".")
end

vim.opt.colorcolumn = "88"
vim.opt.textwidth = 0

map("n", "<leader>pp", function()
  local import_path = getImportPath()
  vim.api.nvim_put({ import_path }, "c", true, true)
end, { desc = "Paste the Python import path of the current file" })

map("n", "<leader>yp", function()
  local import_path = getImportPath()
  vim.fn.setreg('"', import_path)
end, { desc = "Copy the Python import path of the current file to the default clipboard" })

map("n", "<leader>Yp", function()
  local import_path = getImportPath()
  vim.fn.setreg("+", import_path)
end, { desc = "Copy the Python import path of the current file to the system clipboard" })

vim.api.nvim_create_user_command("FormatLineAsImportStatement", function(_)
  -- Get the current line content
  local line = vim.api.nvim_get_current_line()

  -- Split the line into parts by the dot separator
  local parts = {}
  for part in string.gmatch(line, "[^.]+") do
    table.insert(parts, part)
  end

  -- Ensure there are enough parts to form a valid import statement
  if #parts < 2 then
    print("Invalid module path")
    return
  end

  -- Get the last part for the import statement
  local item = table.remove(parts)
  -- Join the remaining parts for the from statement
  local module_path = table.concat(parts, ".")

  -- Construct the new line
  local new_line = string.format("from %s import %s", module_path, item)

  -- Set the new line content
  vim.api.nvim_set_current_line(new_line)
end, {})

map(
  "n",
  "<leader>F",
  ":FormatLineAsImportStatement<cr>",
  { desc = "Format the current line containing a Python module path as a module-level import statement" }
)

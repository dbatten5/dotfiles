local map = require("utils.functions").setKeymap

local convert_file_path_to_dotted_path = function(file_path)
  return string.gsub(file_path, "/", ".")
end

local get_current_file_dotted_path = function()
  return convert_file_path_to_dotted_path(vim.fn.expand("%:.:r"))
end

local convert_dotted_path_to_import_statement = function(path)
  -- Split the line into parts by the dot separator
  local parts = {}
  for part in string.gmatch(path, "[^.]+") do
    table.insert(parts, part)
  end

  -- Ensure there are enough parts to form a valid import statement
  if #parts < 2 then
    error("Invalid module path")
  end

  -- Get the last part for the import statement
  local item = table.remove(parts)
  -- Join the remaining parts for the from statement
  local module_path = table.concat(parts, ".")

  -- Construct the new line
  local new_line = string.format("from %s import %s", module_path, item)

  return new_line
end

local get_import_lines = function(buf_nr)
  local parser = vim.treesitter.get_parser(buf_nr, "python")
  local tree = parser:parse()[1]
  local root = tree:root()
  local query = vim.treesitter.query.parse(
    "python",
    [[
    (import_statement) @import
    (import_from_statement) @import
    ]]
  )

  -- Find and print the lines with import statements
  local import_lines = {}
  for _, captures, metadata in query:iter_matches(root, buf_nr, 0, -1) do
    for id, node in pairs(captures) do
      if query.captures[id] == "import" then
        local start_row = node:start()            -- Get the starting line of the node (0-based)
        table.insert(import_lines, start_row + 1) -- Convert to 1-based indexing
      end
    end
  end

  return import_lines
end

vim.opt.colorcolumn = "88"
vim.opt.textwidth = 0

-- override the python module import so that it shows up as a variable hl group
vim.api.nvim_set_hl(0, "@module.python", { link = "@variable" })

-- map("n", "<leader>pp", function()
--   local import_path = get_current_file_dotted_path()
-- vim.api.nvim_put({ import_path }, "c", true, true)
-- end, { desc = "Paste the Python import path of the current file" })

map("n", "<leader>yp", function()
  local import_path = get_current_file_dotted_path()
  vim.fn.setreg('"', import_path)
end, { desc = "Copy the Python import path of the current file to the default clipboard" })

map("n", "<leader>Yp", function()
  local import_path = get_current_file_dotted_path()
  vim.fn.setreg("+", import_path)
end, { desc = "Copy the Python import path of the current file to the system clipboard" })

vim.api.nvim_create_user_command("FormatLineAsImportStatement", function(_)
  -- Get the current line content
  local line = vim.api.nvim_get_current_line()

  local importStatement = convert_dotted_path_to_import_statement(line)

  -- Set the new line content
  vim.api.nvim_set_current_line(importStatement)
end, {})

map(
  "n",
  "<leader>F",
  ":FormatLineAsImportStatement<cr>",
  { desc = "Format the current line containing a Python module path as a module-level import statement" }
)

vim.api.nvim_create_user_command("PasteImportStatement", function(_)
  -- This command finds all open python buffers that aren't the current buffer and then, if there is only one other open
  -- non-current buffer, inserts an import statement in the active buffer. If there are multiple open non-current
  -- buffers it'll bring up a select menu so you can choose which one to import from. It relies on treesitter to find
  -- where to insert the statement in the current buffer.
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  local active_other_buffer_file_paths = {}

  for _, buf in ipairs(buffers) do
    if buf ~= current_buf then
      local is_listed = vim.api.nvim_get_option_value("buflisted", { buf = buf })
      local is_displayed = vim.fn.bufwinnr(buf) ~= -1
      local file_path = vim.api.nvim_buf_get_name(buf)
      local is_python = file_path:sub(-3) == ".py"
      if file_path and is_python and is_listed and is_displayed then
        table.insert(active_other_buffer_file_paths, file_path)
      end
    end
  end

  local selected_filepath = nil

  if #active_other_buffer_file_paths == 0 then
    vim.notify("No active other buffer", vim.log.levels.INFO)
    return
  end

  if #active_other_buffer_file_paths == 1 then
    selected_filepath = active_other_buffer_file_paths[1]
    local trimmed_file_path = vim.fn.fnamemodify(selected_filepath, ":.:r")
    local dotted_path = convert_file_path_to_dotted_path(trimmed_file_path)
    local import_statement = convert_dotted_path_to_import_statement(dotted_path)

    local import_lines = get_import_lines(current_buf)
    local last_import_line = import_lines[#import_lines]

    vim.api.nvim_buf_set_lines(current_buf, last_import_line, last_import_line, false, { import_statement })
  else
    vim.ui.select(active_other_buffer_file_paths, {
      prompt = "Pick a module...",
      format_item = function(item)
        return vim.fn.fnamemodify(item, ":t")
      end,
    }, function(choice)
      if choice then
        local trimmed_file_path = vim.fn.fnamemodify(choice, ":.:r")
        local dotted_path = convert_file_path_to_dotted_path(trimmed_file_path)
        local import_statement = convert_dotted_path_to_import_statement(dotted_path)

        local import_lines = get_import_lines(current_buf)
        local last_import_line = import_lines[#import_lines]

        vim.api.nvim_buf_set_lines(current_buf, last_import_line, last_import_line, false, { import_statement })
      else
        vim.notify("No file path from which to build an import statement", vim.log.levels.ERROR)
        return
      end
    end)
  end
end, {})

map(
  "n",
  "<leader>pp",
  ":PasteImportStatement<cr>",
  { desc = "Paste the import path of the other active buffer into the current buffer" }
)

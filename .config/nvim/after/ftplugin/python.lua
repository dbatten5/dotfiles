local treesitter = require("utils.treesitter")
local utils = require("utils.functions")
local buf_utils = require("utils.buffers")
local map = utils.setKeymap

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
  local active_other_buffers = buf_utils.get_other_active_buffers("python")

  if #active_other_buffers == 0 then
    vim.notify("No active other buffer", vim.log.levels.INFO)
    return
  end

  if #active_other_buffers == 1 then
    local selected_filepath = active_other_buffers[1].file_path
    local trimmed_file_path = vim.fn.fnamemodify(selected_filepath, ":.:r")
    local dotted_path = convert_file_path_to_dotted_path(trimmed_file_path)
    local import_statement = convert_dotted_path_to_import_statement(dotted_path)

    local import_lines = treesitter.get_import_lines(current_buf)
    local last_import_line = import_lines[#import_lines] or 0

    vim.api.nvim_buf_set_lines(current_buf, last_import_line, last_import_line, false, { import_statement })
  else
    vim.ui.select(active_other_buffers, {
      prompt = "Pick a module...",
      format_item = function(item)
        return vim.fn.fnamemodify(item.file_path, ":t")
      end,
    }, function(choice)
      if choice then
        local trimmed_file_path = vim.fn.fnamemodify(choice.file_path, ":.:r")
        local dotted_path = convert_file_path_to_dotted_path(trimmed_file_path)
        local import_statement = convert_dotted_path_to_import_statement(dotted_path)

        local import_lines = treesitter.get_import_lines(current_buf)
        local last_import_line = import_lines[#import_lines] or 0

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

local import_patterns = {
  { pattern = "import datetime", priority = 60 },
  { pattern = "import enum", priority = 40 },
  { pattern = "import pytest", priority = 50 },
  { pattern = "import time_machine", priority = 20 },
  { pattern = "from decimal import Decimal", priority = 10 },
  { pattern = "from django.db.models import Q", priority = 5 },
  { pattern = "import attrs", priority = 41 },
  { pattern = "import typing", priority = 52 },
  { pattern = "from collections.abc import Iterable", priority = 23 },
}

--- Bring up a select menu with common import statements and insert the choice
local function paste_common_import()
  local function sort_by_priority(pattern1, pattern2)
    return pattern1.priority > pattern2.priority
  end
  local patterns = vim.fn.extend(vim.g.import_patterns or {}, import_patterns)
  table.sort(patterns, sort_by_priority)
  vim.ui.select(patterns, {
    prompt = "Pick a common import...",
    format_item = function(item)
      return item.pattern
    end,
  }, function(choice)
    if choice then
      local current_buf = vim.api.nvim_get_current_buf()
      local import_lines = treesitter.get_import_lines(current_buf)
      local last_import_line = import_lines[#import_lines] or 0
      vim.api.nvim_buf_set_lines(current_buf, last_import_line, last_import_line, false, { choice.pattern })
    else
      vim.notify("No import selected", vim.log.levels.INFO)
      return
    end
  end)
end

map({ "n", "i" }, "<c-m>", function()
  paste_common_import()
end, { desc = "Paste a common import statement" })

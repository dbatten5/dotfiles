local ts_utils = require("nvim-treesitter.ts_utils")

local M = {}

---@enum definition_types
M.DEFINITION_TYPES = {
  FUNCTIONS = "functions",
  CLASSES = "classes",
  ALL = "all",
}

--- Return a list of definitions defined in a given buffer
---@param bufnr integer the buffer number
---@return table<string, table<string>> a list of the names of the definitions in the buffer
function M.get_definitions(bufnr)
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local tree = language_tree:parse()[1]

  local query = vim.treesitter.query.parse(
    filetype,
    [[
      (function_definition name: (identifier) @functions)
      (class_definition name: (identifier) @classes)
    ]]
  )

  local results = { functions = {}, classes = {}, all = {} }

  for id, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
    local capture_name = query.captures[id]
    local definition_name = vim.treesitter.get_node_text(node, bufnr)
    table.insert(results[capture_name], definition_name)
    table.insert(results[M.DEFINITION_TYPES.ALL], definition_name)
  end

  return results
end

--- Return a list of line numbers which contain import statements
--- note that if an import statement spans multiple lines, this will return the last
--- line of the statement.
---@param bufnr integer the buffer number
---@return table<integer> a list of line numbers that contain import statements
function M.get_import_lines(bufnr)
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local parser = vim.treesitter.get_parser(bufnr, filetype)
  local tree = parser:parse()[1]
  local root = tree:root()
  local query = vim.treesitter.query.parse(
    filetype,
    [[
    (import_statement) @import
    (import_from_statement) @import
    ]]
  )

  -- Find and print the lines with import statements
  local import_lines = {}
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    if node and query.captures[id] == "import" then
      local end_row, _, _ = node:end_() -- Get the end line of the node (0-based)
      table.insert(import_lines, end_row + 1) -- Convert to 1-based indexing
    end
  end

  return import_lines
end

---@enum node_types
M.NODE_TYPES = {
  CLASS = "class_definition",
  FUNCTION = "function_definition",
}

--- Check whether the node under the cursor is descendent of a certain type of node
---@param node_type node_types the type of node to check against
---@return boolean
function M.node_under_cursor_has_parent(node_type)
  local cursor_node = ts_utils.get_node_at_cursor()
  if not cursor_node then
    return false
  end

  while cursor_node do
    if cursor_node:type() == node_type then
      return true
    end
    cursor_node = cursor_node:parent()
  end

  return false
end

return M

local M = {}

--- Return a list of function names defined in a given buffer
---@param bufnr integer the buffer number
---@return table<string> a list of the names of the functions defined in the buffer
function M.get_function_definitions(bufnr)
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
  local language_tree = vim.treesitter.get_parser(bufnr, filetype)
  local tree = language_tree:parse()[1]

  local query = vim.treesitter.query.parse(
    filetype,
    [[
      (function_definition name: (identifier) @function_name)
    ]]
  )

  local results = {}
  for _, node, _ in query:iter_captures(tree:root(), bufnr, 0, -1) do
    local name = vim.treesitter.get_node_text(node, bufnr)
    table.insert(results, name)
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
  for _, captures, _ in query:iter_matches(root, bufnr, 0, -1) do
    for id, node in pairs(captures) do
      if query.captures[id] == "import" then
        local end_row = node:end_() -- Get the end line of the node (0-based)
        table.insert(import_lines, end_row + 1) -- Convert to 1-based indexing
      end
    end
  end

  return import_lines
end

return M

local ls = require("luasnip")

local buf_utils = require("utils.buffers")
local text_utils = require("utils.text")
local utils = require("utils.functions")
local ts_utils = require("utils.treesitter")

local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node
local t = ls.text_node
local c = ls.choice_node

local M = {}

--- Return today's date
---@param fmt string?
---@return string|osdate
function M.todays_date(_, _, fmt)
  fmt = fmt or "%Y-%m-%d"
  return os.date(fmt)
end

--- Convert a plural word to singular, for use in for loops
---@param input string the input to convert to singular
---@return string the singular form of the input
function M.singular(input)
  local plural_word = input[1][1]
  local last_word = string.match(plural_word, "[_%w]*$")

  -- initialize with fallback
  local singular_word = "item"

  if string.match(last_word, ".s$") then
    -- assume the given input is plural if it ends in s. This isn't always
    -- perfect, but it's pretty good
    singular_word = string.gsub(last_word, "s$", "", 1)
  elseif string.match(last_word, "^_?%w.+") then
    -- include an underscore in the match so that inputs like '_name' will
    -- become '_n' and not just '_'
    singular_word = string.match(last_word, "^_?.")
  end

  return sn("{}", i(1, singular_word))
end

--- Return an insert node that has its default value as the same as another node
---@param index integer the jump index
---@param as integer the node from which to insert the output as the default value
---@return any a dynamic node
function M.same(index, as)
  return d(index, function(args)
    return sn("{}", i(1, args[1][1]))
  end, { as })
end

--- Return a choice node filled with defintions from other open buffers
---@param index integer the jump index
---@param filetype string the filetype to filter other active buffers by
---@param definition_type definition_types the type of definitions to look for
---@param format_definition? function an optional function used to format the defintions
---@return any a choice node
function M.definitions_choice_node(index, filetype, definition_type, format_definition)
  format_definition = format_definition or text_utils.convert_to_pascal
  return d(index, function()
    local nodes = {}
    local other_bufs = buf_utils.get_other_active_buffers(filetype)
    for _, buf in ipairs(other_bufs) do
      local defs = ts_utils.get_definitions(buf.bufnr)[definition_type]
      for _, def in ipairs(utils.reverse_table(defs)) do
        table.insert(nodes, t(format_definition(def)))
      end
    end
    if #nodes == 0 then
      nodes = { t("") }
    end
    return sn(nil, c(1, nodes))
  end)
end

return M

local ls = require("luasnip")
local sn = ls.snippet_node
local i = ls.insert_node
local d = ls.dynamic_node

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

return M

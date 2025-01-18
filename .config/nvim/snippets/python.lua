--- Replace the whitespace in a string with underscores
---@param str string the string to replace
---@return string the replaced string
local function replace_whitespace(str)
  return string.gsub(str, "%s", "_")
end

--- Return today's date
---@param fmt string?
---@return string|osdate
local function todays_date(_, _, fmt)
  fmt = fmt or "%Y-%m-%d"
  return os.date("%Y-%m-%d")
end

--- Check whether the node under the cursor is within a class definition
---@return boolean
local function node_under_cursor_is_in_class()
  local ts_utils = require("nvim-treesitter.ts_utils")

  local cursor_node = ts_utils.get_node_at_cursor()
  if not cursor_node then
    return false
  end

  while cursor_node do
    if cursor_node:type() == "class_definition" then
      return true
    end
    cursor_node = cursor_node:parent()
  end

  return false
end

--- Insert class aware function arguments, i.e. start with a `self` if we're inside a class
---@param index integer the node index
---@param args_unlikely boolean? whether the argument is unlikely to contain more than just `self`
---@return any a dynamic node
local function class_aware_fn_args(index, args_unlikely)
  return d(index, function()
    local nodes = {}
    if node_under_cursor_is_in_class() then
      local choice_nodes = {
        sn(nil, {
          t(", "),
          i(1),
        }),
        i(1),
      }
      if args_unlikely then
        choice_nodes = {
          i(1),
          sn(nil, {
            t(", "),
            i(1),
          }),
        }
      end
      nodes = {
        t("self"),
        c(1, choice_nodes),
      }
    else
      nodes = {
        i(1),
      }
    end
    return sn(nil, nodes)
  end)
end

--- Convert a plural word to singular, for use in for loops
---@param input string the input to convert to singular
---@return string the singular form of the input
local function singular(input)
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

  return s("{}", i(1, singular_word))
end

return {
  -- function
  s(
    "f",
    fmt(
      [[
    def {}({}){}:
        {}
    ]],
      {
        i(1),
        class_aware_fn_args(2),
        c(3, {
          sn(nil, {
            t(" -> "),
            i(1),
          }),
          i(nil),
        }),
        i(4),
      }
    )
  ),

  -- test  function
  s(
    "test",
    fmt(
      [[
    def test_{}({}):
        {}
    ]],
      {
        i(1),
        class_aware_fn_args(2, true),
        c(3, {
          r(1, "test_body", i(1)),
          fmt(
            [[
          """
            {}
            """
            {}
          ]],
            {
              r(1, "test_docs", i(1)),
              r(2, "test_body", i(2)),
            }
          ),
        }),
      }
    )
  ),

  -- if
  s(
    "if",
    fmt(
      [[
    if {}:
        {}
    ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  s("pry", t("breakpoint()")),

  s("s", t("self.")),

  -- class
  s(
    "class",
    fmt(
      [[
    class {}:
        {}
        def __init__(self, {}):
            {}
    ]],
      {
        i(1),
        c(2, {
          i(1),
          fmt(
            [[
            """
            \t{}
            \t"""
            ]],
            {
              i(1),
            },
            {
              indent_string = [[\t]],
            }
          ),
        }),
        i(3),
        i(4),
      }
    )
  ),

  -- test class
  s(
    "tc",
    fmt(
      [[
    class Test{}:
        {}
    ]],
      {
        i(1),
        c(2, {
          i(1),
          fmt(
            [[
            """
            \t{}
            \t"""
            \t{}
            ]],
            {
              i(1),
              i(2),
            },
            {
              indent_string = [[\t]],
            }
          ),
        }),
      }
    )
  ),

  -- pytest parametrize
  s(
    "param",
    fmt(
      [[
    @pytest.mark.parametrize(
        "{}",
        [
            ({}),
        ]
    )
    ]],
      {
        i(1),
        i(2),
      }
    )
  ),

  -- @time_machine travel to now
  s(
    "tm",
    fmt(
      [[
    @time_machine.travel("{}")
    ]],
      {
        f(todays_date),
      }
    )
  ),

  -- __init__
  s(
    "init",
    fmt(
      [[
    def __init__(self, {}) -> None:
        {}
    ]],
      {
        i(1),
        d(2, function(args)
          local nodes = {}
          if args[1][1] then
            for arg in args[1][1]:gmatch("([^,]+)") do
              local var_name = arg:match("[%a_][%w_]*")
              if var_name then
                table.insert(nodes, t({ "self." .. var_name .. " = " .. var_name, "\t" }))
              end
            end
          end
          return sn(nil, nodes)
        end, { 1 }),
      }
    )
  ),

  -- for loop
  s(
    "for",
    fmt(
      [[
      for {} in {}:
          {}
      ]],
      {
        d(2, singular, { 1 }),
        i(1),
        i(3),
      }
    )
  ),

  -- docstring
  s(
    "ds",
    c(1, {
      sn(
        nil,
        fmt(
          [[
      """
      {}
      """
      ]],
          { r(1, "doc_body", i(1)) }
        )
      ),
      sn(nil, {
        t('"""'),
        r(1, "doc_body", i(1)),
        t('"""'),
      }),
    })
  ),
}

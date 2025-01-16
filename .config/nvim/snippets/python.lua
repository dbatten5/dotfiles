local function replace_whitespace(str)
  return string.gsub(str, "%s", "_")
end

local function todays_date()
  return os.date("%Y-%m-%d")
end

local function node_under_cursor_is_in_class()
  local ts_utils = require("nvim-treesitter.ts_utils")

  -- Get the current cursor position
  local cursor_node = ts_utils.get_node_at_cursor()
  if not cursor_node then
    return false
  end

  -- Traverse up the syntax tree
  while cursor_node do
    -- Check if the current node is a class (adjust the `class` to match your language's tree-sitter node type)
    if cursor_node:type() == "class_definition" then
      return true
    end
    cursor_node = cursor_node:parent()
  end

  return false
end

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
          i(nil),
          sn(nil, {
            t(" -> "),
            i(1),
          }),
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
        """{}"""

        def __init__(self, {}):
            {}
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
      }
    )
  ),

  s("trig", t("goodby")),

  -- test class
  s(
    "tc",
    fmt(
      [[
    class Test{}:
        """{}"""
    ]],
      {
        i(1),
        i(2),
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
    ]],
      {
        i(1),
      }
    )
  ),
}

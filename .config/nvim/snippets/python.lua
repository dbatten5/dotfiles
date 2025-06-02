local ls_utils = require("utils.luasnip")
local ts_utils = require("utils.treesitter")

--- Insert class aware function arguments, i.e. start with a `self` if we're inside a class
---@param index integer the node index
---@param args_unlikely boolean? whether the argument is unlikely to contain more than just `self`
---@return any a dynamic node
local function class_aware_fn_args(index, args_unlikely)
  return d(index, function()
    local nodes
    if ts_utils.node_under_cursor_has_parent(ts_utils.NODE_TYPES.CLASS) then
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

--- Input a choice node that cycles between doc styles (or no docs)
---@param index integer the jump index
---@return any a choice node for the docs snippet
local function collapsible_docs(index)
  return isn(index, {
    c(1, {
      t(""),
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
    }),
  }, "$PARENT_INDENT\t")
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
        collapsible_docs(3),
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
        def __init__(self, {}) -> None:
            {}
    ]],
      {
        i(1),
        collapsible_docs(2),
        i(3),
        d(4, function(args)
          local nodes = {}
          if args[1][1] then
            for arg in args[1][1]:gmatch("([^,]+)") do
              local var_name = arg:match("[%a_][%w_]*")
              if var_name then
                table.insert(nodes, t({ "self." .. var_name .. " = " .. var_name, "" }))
              end
            end
          end
          return isn(nil, nodes, "$PARENT_INDENT\t\t")
        end, { 3 }),
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
        ls_utils.definitions_choice_node(1, "python", ts_utils.DEFINITION_TYPES.ALL),
        collapsible_docs(2),
      }
    )
  ),

  -- test class for a function
  s(
    "tcf",
    fmt(
      [[
    class Test{}:
        {}
    ]],
      {
        ls_utils.definitions_choice_node(1, "python", ts_utils.DEFINITION_TYPES.FUNCTIONS),
        collapsible_docs(2),
      }
    )
  ),

  -- test class for a class
  s(
    "tcc",
    fmt(
      [[
    class Test{}:
        {}
    ]],
      {
        ls_utils.definitions_choice_node(1, "python", ts_utils.DEFINITION_TYPES.CLASSES),
        collapsible_docs(2),
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

  -- context aware time_machine travel to now
  s(
    "tm",
    fmt(
      [[
    {}time_machine.travel("{}", tick=False){}
    ]],
      {
        d(1, function()
          if ts_utils.node_under_cursor_has_parent(ts_utils.NODE_TYPES.FUNCTION) then
            return sn(nil, t("with "))
          else
            return sn(nil, t("@"))
          end
        end),
        c(2, {
          f(ls_utils.todays_date, {}, { user_args = { "%Y-%m-%d %H:%M:%S" } }),
          f(ls_utils.todays_date),
        }),
        d(3, function()
          if ts_utils.node_under_cursor_has_parent(ts_utils.NODE_TYPES.FUNCTION) then
            return sn(nil, t(":"))
          else
            return sn(nil, t(""))
          end
        end),
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
        d(2, ls_utils.singular, { 1 }),
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

  -- attrs
  s(
    "atr",
    fmt(
      [[
    @attrs.{}
    class {}:
        {}
        {}
    ]],
      {
        c(1, { t("frozen"), t("define") }),
        i(2),
        collapsible_docs(3),
        i(4),
      }
    )
  ),

  -- enum
  s(
    "enum",
    fmt(
      [[
      class {}(enum.{}):
          {}
          {} = "{}"
      ]],
      {
        i(1),
        c(2, {
          t("StrEnum"),
          t("Enum"),
        }),
        collapsible_docs(3),
        i(4, "FOO"),
        ls_utils.same(5, 4),
      }
    )
  ),

  -- enum element
  s(
    "ene",
    fmt([[{} = "{}"]], {
      i(1, "FOO"),
      ls_utils.same(2, 1),
    })
  ),

  -- dict element
  s(
    "de",
    fmt([["{}": {},]], {
      i(1),
      c(2, {
        i(1),
        sn(nil, fmt([["{}"]], { i(1) })),
      }),
    })
  ),

  -- property
  s(
    "prop",
    fmt(
      [[
      @property
      def {}(self) -> {}:
          {}
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  -- class method
  s(
    "clsm",
    fmt(
      [[
      @classmethod
      def {}(cls) -> {}:
          {}
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),

  -- static method
  s(
    "statm",
    fmt(
      [[
      @staticmethod
      def {}({}) -> {}:
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

  -- localtime
  s(
    "lct",
    fmt(
      [[
      localtime.{}
    ]],
      {
        c(1, {
          t("now()"),
          t("today()"),
          t("midnight()"),
          t("yesterday()"),
          t("tomorrow()"),
          sn(nil, fmt([[days_in_the_future({})]], { i(1) })),
          sn(nil, fmt([[days_in_the_past({})]], { i(1) })),
          sn(nil, fmt([[months_in_the_future({})]], { i(1) })),
          sn(nil, fmt([[months_in_the_past({})]], { i(1) })),
        }),
      }
    )
  ),

  -- current date(time)
  s(
    "cdt",
    fmt("{}", {
      c(1, {
        f(ls_utils.todays_date),
        f(ls_utils.todays_date, {}, { user_args = { "%Y-%m-%d %H:%M:%S" } }),
      }),
    })
  ),
}

return {
  -- require statement
  s(
    "req",
    c(1, {
      fmt('require("{}")', {
        r(1, "req_path", i(1)),
      }),
      fmt('local {} = require("{}")', {
        d(2, function(args)
          local var_name = ""
          if args[1][1] then
            var_name = args[1][1]:match("([^%.]+)$")
          end
          return sn(nil, i(1, var_name))
        end, { 1 }),
        r(1, "req_path", i(1)),
      }),
    })
  ),

  -- module
  s(
    "mod",
    fmt(
      [[
    local M = {{}}

    function M.{}({})
    \t{}
    end

    return M
    ]],
      { i(1), i(2), i(3) },
      {
        indent_string = [[\t]],
      }
    )
  ),

  -- function
  s(
    "f",
    c(1, {
      fmt(
        [[
        function M.{}({})
        \t{}
        end
        ]],
        {
          r(1, "fn_name", i(1)),
          r(2, "fn_args", i(2)),
          r(3, "fn_body", i(3)),
        },
        {
          indent_string = [[\t]],
        }
      ),
      fmt(
        [[
        local function {}({})
        \t{}
        end
        ]],
        {
          r(1, "fn_name", i(1)),
          r(2, "fn_args", i(2)),
          r(3, "fn_body", i(3)),
        },
        {
          indent_string = [[\t]],
        }
      ),
    })
  ),

  -- ipairs
  s(
    "ip",
    fmt(
      [[
      for _, {} in ipairs({}) do
      \t{}
      end
      ]],
      {
        i(1, "line"),
        i(2),
        i(3),
      },
      {
        indent_string = [[\t]],
      }
    )
  ),

  -- if
  s(
    "if",
    fmt(
      [[
      if {} then
      \t{}
      end
      ]],
      {
        c(1, {
          i(1),
          sn(nil, {
            t("not "),
            i(1),
          }),
        }),
        i(2),
      },
      {
        indent_string = [[\t]],
      }
    )
  ),

  -- table.insert
  s("tbi", fmt("table.insert({}, {})", { i(1), i(2) })),

  -- vim.tbl_extend
  s(
    "tbe",
    fmt("vim.tbl_extend({}, {}, {})", {
      i(1, '"force"'),
      i(2),
      i(3),
    })
  ),

  -- snippet
  s(
    "snip",
    fmt(
      [=[
    s(
      "{}",
        fmt(
        [[
        {}
      ]],
      {{
        {}
      }}{}
      )
    ),
    ]=],
      {
        i(1),
        i(2),
        i(3),
        c(4, {
          t(""),
          t({ ",", "\t{{", "\t\tindent_string = [[\\t]],", "\t}}" }),
        }),
      },
      {
        indent_string = [[\t]],
      }
    )
  ),

  -- local
  s(
    "l",
    fmt(
      [[
      local {} = {}
    ]],
      {
        i(1),
        c(2, {
          sn(nil, fmt("{{{}}}", { i(1) })),
          i(1),
        }),
      }
    )
  ),
}

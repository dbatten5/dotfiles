local l = require("luasnip.extras").lambda

return {
  -- require statement
  s(
    "req",
    c(1, {
      fmt('require("{}")', {
        r(1, "req_path", i(1)),
      }),
      fmt('local {} = require("{}")', {
        l(l._1:match("([^%.]+)$"), { 1 }),
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

    function M.{}()

    end

    return M
    ]],
      { i(1) }
    )
  ),

  -- function
  s(
    "f",
    c(1, {
      fmt(
        [[
        function M.{}({})
          {}
        end
        ]],
        {
          r(1, "fn_name", i(1)),
          r(2, "fn_args", i(2)),
          r(3, "fn_body", i(3)),
        }
      ),
      fmt(
        [[
        local function {}({})
          {}
        end
        ]],
        {
          r(1, "fn_name", i(1)),
          r(2, "fn_args", i(2)),
          r(3, "fn_body", i(3)),
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
        {}
      end
      ]],
      {
        i(1, "line"),
        i(2),
        i(3),
      }
    )
  ),

  -- if
  s(
    "if",
    fmt(
      [[
      if {} then
        {}
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
      }
    )
  ),

  -- table.insert
  s("tbi", fmt("table.insert({}, {})", { i(1), i(2) })),

  -- vim.tbl_extend
  s(
    "tbe",
    fmt("vim.tbl_extend({}, {}, {})", {
      i(1, "force"),
      i(2),
      i(3),
    })
  ),

  -- for
  sn(
    "for",
    fmt("", {})
  )
}

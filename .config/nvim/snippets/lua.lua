local l = require("luasnip.extras").lambda

return {
  -- require statement
  s("req", fmt('require("{}")', { i(1) })),

  -- require statement with local assignment
  s("lreq", fmt('local {} = require("{}")', { l(l._1:match("([^%.]+)$"), { 1 }), i(1) })),

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
}

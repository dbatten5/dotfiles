return {
  s(
    "plug",
    fmt(
      [[
      -- {}
      {{
        "{}",
      }},
      ]],
      {
        i(1, "comment"),
        i(2),
      }
    )
  ),
  s("req", fmt('require("{}")', { i(1) })),
  s("lreq", fmt('local {} = require("{}")', { rep(1), i(1) })),
}

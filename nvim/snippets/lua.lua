return {
  s(
    'plug', 
    fmt(
      [[
      -- {}
      {{
        '{}',
      }},
      ]],
      {
        i(1, 'comment'),
        i(2)
      }
    )
  ),
  s(
    'req',
    fmt("require('{}')", { i(1) })
  ),
}

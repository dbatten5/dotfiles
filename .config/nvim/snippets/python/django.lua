return {
  -- object manager
  s(
    "om",
    fmt(
      [[
      objects.{}
    ]],
      {
        c(1, {
          sn(nil, fmt("filter({})", { i(1) })),
          sn(nil, fmt("get({})", { i(1) })),
          t("count()"),
          t("all()"),
        }),
      }
    )
  ),

  -- `select_related("")`
  s("sr", fmt([[ .select_related("{}"){} ]], { i(1), i(2) })),

  -- `prefetch_related("")`
  s("pr", fmt([[ .prefetch_related("{}"){} ]], { i(1), i(2) })),
}

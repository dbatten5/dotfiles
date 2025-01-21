return {
  -- object manager
  s(
    "om",
    fmt(
      [[
      .objects.{}
    ]],
      {
        c(1, {
          sn(nil, fmt("filter({})", { i(1) })),
          t("count()"),
          t("all()"),
        }),
      }
    )
  ),
}

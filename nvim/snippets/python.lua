local function replace_whitespace(str)
  return string.gsub(str, "%s", "_")
end

return {
  s(
    "f",
    fmt(
      [[
    def {}({}):
        {}
    ]],
      {
        i(1),
        i(2),
        i(3),
      }
    )
  ),
  s(
    "pry",
    t("breakpoint()")
  ),
}

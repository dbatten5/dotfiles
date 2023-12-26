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
        f(1, function(args)
          return replace_whitespace(args[1].get_text())
        end),
        i(2),
        i(3),
      }
    )
  ),
}

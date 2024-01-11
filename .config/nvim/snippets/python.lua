local function replace_whitespace(str)
  return string.gsub(str, "%s", "_")
end

return {
  -- function
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

  -- test  function
  s(
    "test",
    fmt(
      [[
    def test_{}({}):
        """{}"""
        {}
    ]],
      {
        i(1),
        i(2, "self"),
        i(3),
        i(4),
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
        """{}"""

        def __init__(self, {}):
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

  -- test class
  s(
    "tc",
    fmt(
      [[
    class Test{}:
        """{}"""
    ]],
      {
        i(1),
        i(2),
      }
    )
  ),
}

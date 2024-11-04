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

  s("gbrwf", t("from tests.factories.plugins.territories.gbr.markets import water as gbr_water_factories")),

  s("fdt", t("from tests.factories import datetimes as factory_dt")),

  s("lct", t("from xocto import localtime")),

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

  -- pytest parametrize
  s(
    "param",
    fmt(
      [[
    @pytest.mark.parametrize(
        "test_input,expected",
        [
            ({}, {}),
        ]
    )

    ]],
      {
        i(1),
        i(2),
      }
    )
  ),
}

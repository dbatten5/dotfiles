return {
  "echasnovski/mini.trailspace",
  version = false,
  keys = {
    {
      "<leader>ws",
      function()
        require("mini.trailspace").trim()
      end,
      desc = "Strip trailing whitespace",
    },
  },
}

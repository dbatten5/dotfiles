return {
  "octoenergy/kraken.nvim",
  keys = {
    {
      "<leader>lt",
      "<cmd>KLocateTests<cr>",
      desc = "Locate test file(s)",
    },
  },
  cmd = {
    "KAddTestFile",
  },
  lazy = true,
  dev = true,
  opts = {
    commands = {
      locate_tests = {
        open_command = "lefta vsp",
      },
    },
    picker = "picker",
  },
}

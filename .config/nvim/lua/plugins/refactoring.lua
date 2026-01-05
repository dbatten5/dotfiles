return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  enabled = true,
  lazy = true,
  keys = {
    {
      "<leader>rr",
      function()
        require("refactoring").select_refactor()
      end,
      mode = { "n", "x" },
      desc = "Select refactor",
    },
    {
      "<leader>rp",
      function()
        require("refactoring").debug.printf({ below = false })
      end,
      mode = { "n", "x" },
      desc = "Insert print statement to mark calling of a function",
    },
    {
      "<leader>rv",
      function()
        require("refactoring").debug.print_var()
      end,
      mode = { "n", "x" },
      desc = "Insert print statement to variable",
    },
    {
      "<leader>rc",
      function()
        require("refactoring").debug.cleanup({})
      end,
      mode = { "n", "x" },
      desc = "Clean up any automatically inserted print statements",
    },
  },
  config = function()
    require("refactoring").setup({})
  end,
}

return {
  "danymat/neogen",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "L3MON4D3/LuaSnip",
  },
  keys = {
    {
      "<leader>nf",
      function()
        require("neogen").generate()
      end,
      desc = "Generate docstring",
    },
  },
  config = function()
    require("neogen").setup({ snippet_engine = "luasnip" })
  end,
}

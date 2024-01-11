return {
  "Wansmer/treesj",
  lazy = true,
  keys = { "<space>m" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("treesj").setup()
  end,
}

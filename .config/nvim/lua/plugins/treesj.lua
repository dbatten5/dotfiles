return {
  "Wansmer/treesj",
  lazy = true,
  keys = { "<space>m" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    local tsj_utils = require("treesj.langs.utils")
    local html = require("treesj.langs.html")

    local langs = {
      htmldjango = tsj_utils.merge_preset(html, {}),
    }

    require("treesj").setup()
  end,
}

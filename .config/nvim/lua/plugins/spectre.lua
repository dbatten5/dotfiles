return {
  "nvim-pack/nvim-spectre",
  enabled = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    "<leader>S",
    function()
      require("spectre").toggle()
    end,
    desc = "Toggle Spectre",
  },
  config = function()
    require("spectre").setup()
  end,
}

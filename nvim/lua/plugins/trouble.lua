return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>xx",
      function()
        require("trouble").toggle()
      end,
    },
  },
  opts = {},
}

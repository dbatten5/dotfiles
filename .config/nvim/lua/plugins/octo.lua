return {
  "pwntester/octo.nvim",
  cmd = "Octo",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>op",
      "<cmd>Octo pr create<cr>",
      desc = "Create a new PR for the current branch",
    },
  },
  config = function()
    require("octo").setup()
  end,
}


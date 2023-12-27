return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_hidden = false,
        never_show = {
          ".DS_Store",
        },
      },
    },
  },
  keys = {
    {
      "<leader>E",
      "<cmd>Neotree<cr>",
      desc = "Open Neotree",
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}

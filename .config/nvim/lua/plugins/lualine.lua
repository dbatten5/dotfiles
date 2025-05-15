return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "stevearc/overseer.nvim",
    "nvim-tree/nvim-web-devicons",
    "neovim/nvim-lspconfig",
  },
  opts = {
    theme = "nord",
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        "diagnostics",
      },
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
      lualine_x = { "filetype", "lsp_status" },
      lualine_y = { "overseer", "progress" },
      lualine_z = { "location" },
    },
  },
}

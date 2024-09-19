return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "stevearc/overseer.nvim",
  },
  opts = {
    theme = "nord",
    sections = {
      lualine_c = {
        {
          "filename",
          path = 1,
        },
      },
      lualine_x = {
        "fileformat",
        "filetype",
      },
      lualine_y = {
        "overseer",
      },
    },
  },
}

return {
  "echasnovski/mini.surround",
  version = false,
  opts = {
    mappings = {
      add = "gsa", -- Add surrounding in Normal and Visual modes
      delete = "gsd", -- Delete surrounding
      replace = "gsr", -- Replace surrounding
      update_n_lines = "", -- Update `n_lines`
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "gsh", -- Highlight surrounding
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)
  end,
}

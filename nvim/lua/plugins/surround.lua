return {
  "echasnovski/mini.surround",
  version = false,
  opts = {
    mappings = {
      add = "<space>sa", -- Add surrounding in Normal and Visual modes
      delete = "<space>sd", -- Delete surrounding
      replace = "<space>sr", -- Replace surrounding
      update_n_lines = "", -- Update `n_lines`
      find = "", -- Find surrounding (to the right)
      find_left = "", -- Find surrounding (to the left)
      highlight = "", -- Highlight surrounding
    },
  },
  config = function(_, opts)
    require("mini.surround").setup(opts)
  end,
}

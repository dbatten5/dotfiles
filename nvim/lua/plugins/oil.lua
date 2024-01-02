return {
  "stevearc/oil.nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return (name == ".DS_Store")
      end,
    },
    keymaps = {
      ["<c-r>"] = "actions.refresh",
      ["<c-x>"] = "actions.select_split",
      ["<c-v>"] = "actions.select_vsplit",
      ["<c-h>"] = false,
      ["<c-l>"] = false,
    },
  },
  keys = {
    { "<c-e>", "<cmd>Oil<cr>", desc = "Open Oil explorer" },
  },
}

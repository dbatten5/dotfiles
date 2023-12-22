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
      is_hidden_file = function(name, _)
        return (name == ".DS_Store")
      end,
    },
    keymaps = {
      ["<C-r>"] = "actions.refresh",
      ["<C-x>"] = "actions.select_split",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  },
  keys = {
    { "<c-e>", "<cmd>Oil<cr>", desc = "Open Oil explorer" },
  },
}

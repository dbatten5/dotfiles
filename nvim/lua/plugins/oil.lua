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
      ["<C-r>"] = "actions.refresh",
      ["<C-x>"] = "actions.select_split",
      ["<C-v>"] = "actions.select_vsplit",
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["__"] = {
        callback = function()
          local path = require("oil").get_current_dir() .. "__init__.py"
          local file = io.open(path, "r")
          if file then
            print("__init__.py already exists - not overwriting")
            file:close()
          else
            local new_file = io.open(path, "w")
            if new_file then
              new_file:close()
              require("oil.actions").refresh.callback()
            end
          end
        end,
        desc = "Insert an __init__.py",
        mode = "n",
      },
    },
  },
  keys = {
    { "<c-e>", "<cmd>Oil<cr>", desc = "Open Oil explorer" },
  },
}

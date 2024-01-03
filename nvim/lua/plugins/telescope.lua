return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "ahmedkhalf/project.nvim",
      "ThePrimeagen/harpoon",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = {
      { "<c-f>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<c-b>", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<space>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      { "<space>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<space>fm", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<space>fw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
      {
        "<space>fs",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Word search",
      },
      { "<space>f;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      { "<space>fb", "<cmd>Telescope git_branches<cr>", desc = "Git branches" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<c-z>"] = actions.delete_buffer,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = false,
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
          },
        },
      })
      telescope.load_extension("fzf")
      telescope.load_extension("projects")
      telescope.load_extension("harpoon")
    end,
  },

  -- telescope imports
  {
    "piersolenski/telescope-import.nvim",
    dependencies = "nvim-telescope/telescope.nvim",
    keys = {
      { "<space>fi", "<cmd>Telescope import<cr>", desc = "Imports" },
    },
    config = function()
      require("telescope").load_extension("import")
    end,
  },
}

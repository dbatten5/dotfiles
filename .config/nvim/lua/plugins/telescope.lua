return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    cmd = "Telescope",
    keys = {
      {
        "<c-f>",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
          })
        end,
        desc = "Find files",
      },
      { "<c-b>", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      { "<space>fp", "<cmd>Telescope projects<cr>", desc = "Projects" },
      { "<space>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
      { "<space>fm", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      {
        "<space>fw",
        function()
          require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
        end,
        desc = "Word search",
        mode = "n",
      },
      {
        "<space>fw",
        function()
          require("telescope-live-grep-args.shortcuts").grep_visual_selection()
        end,
        desc = "Word search for visual selection",
        mode = "v",
      },
      {
        "<space>fs",
        function()
          require("telescope").extensions.live_grep_args.live_grep_args()
        end,
        desc = "Word search",
      },
      {
        "<space>fd",
        function()
          local cwd = require("telescope.utils").buffer_dir()
          if vim.bo.filetype == "oil" then
            local oil_cwd = require("oil").get_current_dir()
            if oil_cwd then
              cwd = oil_cwd
            end
          end
          local opts = {
            cwd = cwd,
            prompt_title = "Find string relative to " .. require("utils.functions").truncateFilepath(cwd),
          }
          require("telescope.builtin").live_grep(opts)
        end,
        desc = "Word search from current buffer (or Oil explorer)",
      },
      { "<space>f;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
      {
        "<space>fb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<space>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<space>D",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<c-j>"] = actions.move_selection_next,
              ["<c-k>"] = actions.move_selection_previous,
              ["<c-z>"] = actions.delete_buffer,
              ["<c-h>"] = actions.cycle_history_prev,
              ["<c-l>"] = actions.cycle_history_next,
            },
          },
          path_display = {
            truncate = 3,
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
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-p>"] = lga_actions.quote_prompt(),
                ["<M-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<M-t>"] = lga_actions.quote_prompt({ postfix = " --iglob !tests" }),
                ["<M-w>"] = lga_actions.quote_prompt({ postfix = " --iglob **/*water*/**" }),
                ["<M-f>"] = lga_actions.quote_prompt({ postfix = " -t" }),
                ["<C-space>"] = lga_actions.to_fuzzy_refine,
              },
            },
          },
          import = {
            custom_languages = {
              extensions = { "py" },
              filetypes = { "python" },
            },
          },
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("live_grep_args")
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

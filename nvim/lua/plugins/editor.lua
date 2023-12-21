return {
  -- file explorer
  {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, _)
          return (name == '.DS_Store')
        end,
      }
    },
    keys = {
      { '<c-e>', '<cmd>Oil<cr>', desc = 'Open Oil explorer' },
    },
  },

  -- fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    keys = {
      { '<c-f>', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
      { '<leader>fp', '<cmd>Telescope projects<cr>', desc = 'Projects' },
      { '<leader>fw', '<cmd>Telescope grep_string<cr>', desc = 'Word under cursor' },
      {
        '<leader>fs',
        '<cmd>lua require"telescope.builtin".grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }<cr>',
        desc = 'Word search',
      },
      { '<leader>f;', '<cmd>Telescope command_history<cr>', desc = 'Command history' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        pickers = {
          find_files = {
            hidden = false,
          },
          buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
          }
        }
      })
      telescope.load_extension('fzf')
      telescope.load_extension('projects')
    end
  },

  -- project management,
  {
    'ahmedkhalf/project.nvim',
  },

  -- tests
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-python',
    },
    keys = {
      { '<leader>tf', function() require('neotest').run.run() end, desc = 'Run nearest' },
      { '<leader>tt', function() require('neotest').run.run(vim.fn.expand("%")) end, desc = 'Run file' },
      { '<leader>tT', function() require('neotest').run.run(vim.loop.cwd()) end, desc = 'Run all' },
      { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Toggle summary' },
      { '<leader>to', function() require('neotest').output.open({ enter = true, auto_close = true }) end, desc = 'Show output' },
      { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Toggle output panel' },
      { '<leader>tS', function() require('neotest').run.stop() end, desc = 'Stop' },
    },
    config = function()
      require('neotest').setup({
        adapters = {
          require('neotest-python'),
        }
      })
    end
  },

  -- dap
  {
    'mfussenegger/nvim-dap',
    optional = true,
    keys = {
      { '<leader>td', function() require('neotest').run.run({strategy = 'dap'}) end, desc = 'Debug nearest' }
    },
  }

  -- undo

}

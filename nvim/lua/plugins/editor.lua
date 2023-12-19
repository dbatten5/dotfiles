return {
  -- file explorer
  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {
      default_file_explorer = true,
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = true,
        is_hidden_file = function(name, bufnr)
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
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}

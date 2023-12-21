return {
  -- autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      enable_check_bracket_line = false,
      check_ts = true,
    },
  },

  -- comments
  {
    'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<leader>c',
      },
      opleader = {
        line = '<leader>c',
      },
      mappings = {
        basic = true,
        extras = true,
      },
    },
    lazy = false,
  },

  -- better word motions
  {
    'chaoren/vim-wordmotion',
  },

  -- git
  {
    'NeogitOrg/neogit',
    cmd = 'Neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim'
    },
    config = true,
    opts = {
      integrations = {
        telescope = true,
        diffview = true,
      },
      kind = 'split',
    },
    keys = {
      { '<space>g', '<cmd>Neogit<cr>', desc = 'Open Neogit' }
    },
  },

  -- surround
  {
    'echasnovski/mini.surround',
    version = false,
    config = function()
      require('mini.surround').setup()
    end
  }
}

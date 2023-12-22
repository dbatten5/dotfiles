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

  -- completion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        completion = {
          completeopt = 'menu,menuone,preview,noselect',
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-p>"] = cmp.mapping.select_next_item(),
          ["<c-n>"] = cmp.mapping.select_prev_item(),
          ["<c-b>"] = cmp.mapping.scroll_docs(-4),
          ["<c-f>"] = cmp.mapping.scroll_docs(4),
          ["<c-space>"] = cmp.mapping.complete(),
          ["<c-e>"] = cmp.mapping.abort(),
          ["<cr>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = 'buffer' },
          { name = 'path' },
        }),
      })
    end
  },

  -- surround
  {
    'echasnovski/mini.surround',
    version = false,
    opts = {
      mappings = {
        add = '<space>sa', -- Add surrounding in Normal and Visual modes
        delete = '<space>sd', -- Delete surrounding
        replace = '<space>sr', -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
      },
    },
    config = function(_, opts)
      require('mini.surround').setup(opts)
    end
  },
}

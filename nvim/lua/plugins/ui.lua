return {
  -- colourscheme
  {
   'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.nord_italic = false
      vim.g.nord_bold = false
      vim.g.nord_borders = true
      vim.g.nord_uniform_diff_background = true
    end,
  },

  -- better UI window
  {
    'stevearc/dressing.nvim',
    opts = {}
  },

  -- devicons
  {
    'nvim-tree/nvim-web-devicons',
  },

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      theme = 'nord',
      sections = {
        lualine_x = { 'fileformat', 'filetype' }
      },
    },
  },

  -- show indent lines
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '|',
        tab_char = '|',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
  }
}

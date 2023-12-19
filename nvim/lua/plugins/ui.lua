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
  }
}

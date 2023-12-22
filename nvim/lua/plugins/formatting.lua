return {
  {
    -- split/join blocks of code
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesj').setup()
    end
  },

  -- trailing whitespace
  {
    'echasnovski/mini.trailspace',
    version = false,
    keys = {
      {
        '<leader>ws',
        function() require('mini.trailspace').trim() end,
        desc = 'Strip trailing whitespace',
      }
    },
  },
}

return {
  {
    'L3MON43/LuaSnip',
    event = 'InsertEnter',
    opts = {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
    },
    keys = {
      {
        '<c-k>',
        function()
          ls = require('luasnip')
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end,
        mode = { 'i', 's' },
        desc = 'Expand or jump snippet',
        -- silent = true,
      },
      {
        '<c-j>',
        function()
          ls = require('luasnip')
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end,
        mode = { 'i', 's' },
        desc = 'Jump back in snippet',
        -- silent = true,
      },
      {
        '<c-l>',
        function()
          ls = require('luasnip')
          if ls.choice_active() then
            ls.change_choice(1)
          end
        end,
        desc = 'Select snippet choice',
        mode = 'i',
      },
      {'<leader><leader>s', '<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<cr>'}
    },
    config = function(_, opts)
      require('luasnip').config.set_config(opts)
      require('luasnip.loaders.from_lua').load({paths = '~/.config/nvim/snippets/'})
    end
  }
}

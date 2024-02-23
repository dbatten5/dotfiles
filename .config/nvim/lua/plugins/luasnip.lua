return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  opts = {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  },
  keys = {
    {
      "<c-k>",
      function()
        local ls = require("luasnip")
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end,
      mode = { "i", "s" },
      desc = "Expand or jump snippet",
      silent = true,
    },
    {
      "<c-j>",
      function()
        local ls = require("luasnip")
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end,
      mode = { "i", "s" },
      desc = "Jump back in snippet",
      silent = true,
    },
    -- {
    --   "<c-l>",
    --   function()
    --     local ls = require("luasnip")
    --     if ls.choice_active() then
    --       ls.change_choice(1)
    --     end
    --   end,
    --   desc = "Select snippet choice",
    --   mode = "i",
    -- },
    {
      "<leader><leader>s",
      "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<cr>",
      desc = "Source the snippets",
    },
    {
      "<leader>so",
      function()
        require("luasnip.loaders").edit_snippet_files()
      end,
      desc = "Open the snippets",
    },
  },
  config = function(_, opts)
    require("luasnip").config.set_config(opts)
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
  end,
}

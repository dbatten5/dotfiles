return {
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim",
    "saadparwaiz1/cmp_luasnip",
  },
  opts = function(_, opts)
    opts.sources = opts.sources or {}
    table.insert(opts.sources, {
      name = "lazydev",
      group_index = 0, -- set group index to 0 to skip loading LuaLS completions
    })
  end,
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    cmp.setup({
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
        }),
      },
      completion = {
        -- autocomplete = false,
        completeopt = "menu,noselect",
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      view = {
        docs = {
          auto_open = false,
        },
      },
      experimental = {
        ghost_text = false,
      },
      mapping = cmp.mapping.preset.insert({
        ["<c-p>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<c-n>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<c-b>"] = cmp.mapping.scroll_docs(-4),
        ["<c-f>"] = cmp.mapping.scroll_docs(4),
        ["<c-g>"] = function()
          if cmp.visible_docs() then
            cmp.close_docs()
          else
            cmp.open_docs()
          end
        end,
        ["<c-space>"] = cmp.mapping.complete(),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<cr>"] = cmp.mapping.confirm({ select = false }),
      }),
      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, _)
            return require("cmp.types").lsp.CompletionItemKind[entry:get_kind()] ~= "Text"
          end,
        },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
          -- keyword_length = 1,
          max_item_count = 10,
        },
        { name = "path" },
        {
          name = "luasnip",
          keyword_length = 1,
        },
      }),
    })

    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        {
          name = "buffer",
          -- keyword_length = 1,
          max_item_count = 10,
        },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })

    vim.keymap.set("i", "<c-p>", "<cmd>lua require('cmp').complete()<cr>")
  end,
}

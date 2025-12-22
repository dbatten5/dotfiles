return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "folke/snacks.nvim",
    {
      "folke/lazydev.nvim",
      config = true,
    },
    {
      "folke/neoconf.nvim",
      enabled = true,
      config = true,
    },
  },
  config = function()
    local lspconfig = vim.lsp.config
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap
    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      opts.nowait = true
      map.set("n", "grr", function()
        require("snacks").picker.lsp_references()
      end, opts)
      opts.nowait = nil

      opts.desc = "Go to declaration"
      map.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      map.set("n", "gd", function()
        require("snacks").picker.lsp_definitions()
      end, opts)

      opts.desc = "Show LSP implementations"
      map.set("n", "gri", function()
        require("snacks").picker.lsp_implementations()
      end, opts)

      opts.desc = "Show LSP type definitions"
      map.set("n", "gt", function()
        require("snacks").picker.lsp_type_definitions()
      end, opts)

      opts.desc = "Show documentation for what is under cursor"
      map.set("n", "K", function()
        vim.lsp.buf.hover({ border = "rounded" })
      end, opts)

      opts.desc = "Signature help"
      map.set("i", "<c-s>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, opts)

      opts.desc = "Restart LSP"
      map.set("n", "<space>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    lspconfig.basedpyright = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig.lua_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig.ts_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }
  end,
}

---@diagnostic disable: 113
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap
    local opts = { noremap = true, silent = true }

    local on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      map.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

      opts.desc = "Go to declaration"
      map.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

      opts.desc = "Show LSP definitions"
      map.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

      opts.desc = "Show LSP implementations"
      map.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

      opts.desc = "Show LSP type definitions"
      map.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

      opts.desc = "See available code actions"
      -- see available code actions, in visual mode will apply to selection
      map.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      map.set("n", "<space>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      map.set("n", "<space>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      map.set("n", "<space>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      map.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      map.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      map.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

      opts.desc = "Signature help"
      map.set("i", "<c-s>", vim.lsp.buf.signature_help, opts) -- show documentation for what is under cursor

      opts.desc = "Restart LSP"
      map.set("n", "<space>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      python = {
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
}

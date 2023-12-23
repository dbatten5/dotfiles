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
      map.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      map.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      map.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      map.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      map.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      opts.desc = "See available code actions"
      map.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      map.set("n", "<space>rn", vim.lsp.buf.rename, opts)

      opts.desc = "Show buffer diagnostics"
      map.set("n", "<space>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

      opts.desc = "Show line diagnostics"
      map.set("n", "<space>d", vim.diagnostic.open_float, opts)

      opts.desc = "Go to previous diagnostic"
      map.set("n", "[d", vim.diagnostic.goto_prev, opts)

      opts.desc = "Go to next diagnostic"
      map.set("n", "]d", vim.diagnostic.goto_next, opts)

      opts.desc = "Show documentation for what is under cursor"
      map.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Signature help"
      map.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)

      opts.desc = "Restart LSP"
      map.set("n", "<space>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    lspconfig.pyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "off",
            autoImportCompletions = true,
            autoSearchPaths = true,
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
          client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
                -- library = {
                --   vim.env.VIMRUNTIME,
                --   -- "${3rd}/luv/library"
                --   -- "${3rd}/busted/library",
                -- },
              },
            },
          })

          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
        return true
      end,
      -- settings = {
      --   Lua = {
      --     diagnostics = {
      --       globals = {
      --         "vim",
      --         "s",
      --         "fmt",
      --         "i",
      --       },
      --     },
      --   },
      -- },
    })
  end,
}

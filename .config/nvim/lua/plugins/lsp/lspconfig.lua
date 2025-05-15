return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
    local lspconfig = require("lspconfig")
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

    -- lspconfig.pyright.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   settings = {
    --     python = {
    --       analysis = {
    --         stubPath = os.getenv("PYTHON_TYPE_STUBS") or "",
    --         typeCheckingMode = "off",
    --         useLibraryCodeForTypes = true,
    --         autoImportCompletions = true,
    --         autoSearchPaths = true,
    --         venvPath = ".",
    --       },
    --     },
    --   },
    -- })

    -- lspconfig.pylsp.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    --   -- root_dir = function(fname)
    --   --   local util = require("lspconfig.util")
    --   --   local root_files = {
    --   --     "setup.cfg",
    --   --     "pyproject.toml",
    --   --     "setup.py",
    --   --     "requirements.txt",
    --   --     "Pipfile"pylsp
    --   --   }
    --   --   return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
    --   -- end,
    -- })

    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}

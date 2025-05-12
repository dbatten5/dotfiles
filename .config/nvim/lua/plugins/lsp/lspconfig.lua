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

    lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
      handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      },
    })

    local on_attach = function(client, bufnr)
      client.server_capabilities.semanticTokensProvider = nil
      opts.buffer = bufnr

      opts.desc = "Show LSP references"
      opts.nowait = true
      map.set("n", "gR", function()
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
      map.set("n", "gi", function()
        require("snacks").picker.lsp_implementations()
      end, opts)

      opts.desc = "Show LSP type definitions"
      map.set("n", "gt", function()
        require("snacks").picker.lsp_type_definitions()
      end, opts)

      opts.desc = "Show documentation for what is under cursor"
      map.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Signature help"
      map.set("i", "<c-s>", vim.lsp.buf.signature_help, opts)

      opts.desc = "Restart LSP"
      map.set("n", "<space>rs", ":LspRestart<CR>", opts)
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    require("lspconfig.ui.windows").default_options.border = "single"

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
      -- root_dir = function(fname)
      --   local util = require("lspconfig.util")
      --   local root_files = {
      --     "setup.cfg",
      --     "pyproject.toml",
      --     "setup.py",
      --     "requirements.txt",
      --     "Pipfile",
      --   }
      --   return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      -- end,
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

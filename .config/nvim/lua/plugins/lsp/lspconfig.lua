return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "folke/neodev.nvim",
      config = function()
        require("neodev").setup({
          library = {
            runtime = false,
            types = true,
          },
        })
      end,
    },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local map = vim.keymap
    local opts = { noremap = true, silent = true }

    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
    }

    vim.diagnostic.config({
      signs = true,
      float = {
        border = "rounded",
      },
    })

    opts.desc = "Show buffer diagnostics"
    map.set("n", "<space>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show line diagnostics"
    map.set("n", "<space>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to previous diagnostic"
    map.set("n", "[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to next diagnostic"
    map.set("n", "]d", vim.diagnostic.goto_next, opts)

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
      map.set({ "n", "x" }, "<space>ca", vim.lsp.buf.code_action, opts)

      opts.desc = "Smart rename"
      map.set("n", "<space>rn", vim.lsp.buf.rename, opts)

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
    --   handlers = handlers,
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

    lspconfig.pylsp.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = handlers,
      root_dir = function(fname)
        local util = require("lspconfig.util")
        local root_files = {
          "setup.cfg",
          "pyproject.toml",
          "setup.py",
          "requirements.txt",
          "Pipfile",
        }
        return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
      end,
      settings = {
        pylsp = {
          plugins = {
            black = { enabled = false },
            ruff = { enabled = false },
            flake8 = { enabled = false },
            pylsp_mypy = {
              enabled = vim.g.pylsp_mypy_enabled or false,
              dmypy = true,
              live_mode = false,
              strict = false,
              -- overrides = { "--cache-dir", "/dev/null", true },
            },
            pydocstype = { enabled = false },
            pycodestyle = { enabled = false },
            pyflakes = { enabled = false },
          },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      handlers = handlers,
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
              -- below for luasnip
              "s",
              "fmt",
              "i",
              "f",
              "t",
            },
          },
        },
      },
    })
  end,
}

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  keys = {
    {
      "<leader>f",
      function()
        vim.lsp.buf.format({ async = true })
      end,
      desc = "Run formatting",
    },
  },
  config = function()
    local nls = require("null-ls")
    local formatting = nls.builtins.formatting
    local diagnostics = nls.builtins.diagnostics
    local completion = nls.builtins.completion

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    nls.setup({
      sources = {
        formatting.stylua,
        formatting.black,
        diagnostics.ruff,
        -- diagnostics.misspell,
        completion.spell,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
          if ft == "lua" then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end
        end
      end,
    })
  end,
}

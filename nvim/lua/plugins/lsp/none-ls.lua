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

    nls.setup({
      sources = {
        formatting.stylua,
        formatting.black,
        diagnostics.luacheck,
        diagnostics.ruff,
        -- diagnostics.misspell,
        completion.spell,
      },
    })
  end,
}

return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      "<leader>f",
      function()
        vim.lsp.buf.format()
      end,
      desc = "Run formatting",
    },
  },
  config = function()
    local nls = require("null-ls")
    nls.setup({
      sources = {
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.black,
        nls.builtins.diagnostics.luacheck,
        nls.builtins.diagnostics.ruff,
        nls.builtins.completion.spell,
      },
    })
  end,
}

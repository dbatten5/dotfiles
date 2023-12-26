return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ensure_installed = {
        "black",
        "debugpy",
        "black",
        "luacheck",
        "mypy",
        "ruff",
        "shellcheck",
        "shfmt",
        "stylua",
      },
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
      },
      automatic_installation = true,
    })
  end,
}

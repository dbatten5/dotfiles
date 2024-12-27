return {
  "williamboman/mason.nvim",
  event = { "BufWritePost", "BufEnter" },
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({
      ui = {
        border = "rounded",
      },
      PATH = "append",
    })

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        -- "pyright",
        "pylsp",
        "ts_ls",
      },
      automatic_installation = true,
    })

    local pylsp = require("mason-registry").get_package("python-lsp-server")
    pylsp:on("install:success", function()
      local function mason_package_path(package)
        local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/mason/packages/" .. package)
        return path
      end

      local path = mason_package_path("python-lsp-server")
      local command = path .. "/venv/bin/pip"
      local args = {
        "install",
        "pylsp-mypy",
      }

      require("plenary.job")
          :new({
            command = command,
            args = args,
            cwd = path,
          })
          :start()
    end)
  end,
}

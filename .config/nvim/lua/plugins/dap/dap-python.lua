return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "williamboman/mason.nvim",
  },
  config = function()
    local debugpy_package = require("mason-registry").get_package("debugpy")
    local path = require("mason-core.package").get_install_path(debugpy_package) .. "/venv/bin/python"
    require("dap-python").setup(path)
  end,
}

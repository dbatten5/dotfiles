return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "fussenegger/nvim-dap",
  },
  config = function()
    local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
    require("dap-python").setup(path)
  end,
}

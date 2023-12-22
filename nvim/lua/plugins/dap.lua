return {
  "mfussenegger/nvim-dap",
  optional = true,
  keys = {
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest",
    },
  },
}

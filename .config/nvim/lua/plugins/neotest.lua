return {
  "nvim-neotest/neotest",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
    "mfussenegger/nvim-dap",
  },
  keys = {
    {
      "<leader>tf",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last",
    },
    {
      "<leader>tL",
      function()
        require("neotest").run.run_last({ strategy = "dap" })
      end,
      desc = "Run last with dap",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run({ strategy = "dap" })
      end,
      desc = "Debug nearest",
    },
    {
      "<leader>tt",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file",
    },
    {
      "<leader>tT",
      function()
        require("neotest").run.run(vim.loop.cwd())
      end,
      desc = "Run all",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.attach()
      end,
      desc = "Attach to the nearest test",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show output window",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
  },
  config = function()
    local neotest = require("neotest")
    local neotest_python = require("neotest-python")

    neotest.setup({
      adapters = {
        neotest_python({
          dap = { justMyCode = true, django = true },
          args = { "-vv", "-p", "tools.pytest.django_config_auto_selection.plugin" },
        }),
      },
      output = { open_on_run = true },
      discovery = {
        enabled = false,
        concurrent = 1,
      },
      summary = {
        animated = false,
      },
    })
  end,
}

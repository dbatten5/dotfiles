return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-python",
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
        neotest_python,
      },
      output = { open_on_run = true },
    })

    neotest.setup_project("~/projects/work/kraken-core", {
      adapters = {
        neotest_python({
          args = { "--dc", "PWLManagementCommand" },
        }),
      },
      discovery = {
        enabled = false,
      },
    })
  end,
}

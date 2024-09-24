return {
  "mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "nvim-neotest/nvim-nio" },
    },
  },
  keys = {
    {
      "<leader>dc",
      function()
        require("dap").continue()
      end,
      desc = "Start debug",
    },
    {
      "<leader>do",
      function()
        require("dap").step_over()
      end,
      desc = "Step over",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into()
      end,
      desc = "Step into",
    },
    {
      "<leader>dx",
      function()
        require("dap").step_out()
      end,
      desc = "Step out",
    },
    {
      "<leader>dr",
      function()
        require("dap").run_to_cursor()
      end,
      desc = "Run to the current cursor",
    },
    {
      "<leader>db",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dB",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Toggle breakpoint with condition",
    },
    {
      "<leader>dh",
      function()
        require("dap.ui.widgets").hover()
      end,
      mode = { "n", "v" },
      desc = "Hover selection",
    },
    {
      "<leader>de",
      function()
        require("dapui").eval(nil, "repl")
      end,
      mode = { "n", "v" },
      desc = "Eval selection",
    },
    {
      "<leader>dR",
      function()
        require("dap").restart()
      end,
      desc = "Restart DAP",
    },
    {
      "<leader>dX",
      function()
        require("dap").terminate()
      end,
      desc = "Finish the debug session",
    },
    {
      "<leader>dC",
      function()
        require("dap").clear_breakpoints()
      end,
      desc = "Clear all breakpoints",
    },
    {
      "<leader>du",
      function()
        require("dapui").toggle()
      end,
      desc = "Toggle UI",
    },
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}

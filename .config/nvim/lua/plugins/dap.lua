return {
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Start debug",
      },
      {
        "<down>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<right>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<left>",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<up>",
        function()
          require("dap").restart_frame()
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
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      dapui.setup()
    end,
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("dap-python").setup("uv")
    end,
  },
}

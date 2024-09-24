return {
  "stevearc/overseer.nvim",
  lazy = false,
  keys = {
    {
      "<leader>or",
      ":OverseerRun<cr>",
      desc = "Open the Overseer task runner",
      silent = true,
    },
    {
      "<leader>ot",
      ":OverseerToggle<cr>",
      desc = "Open the Overseer menu",
      silent = true,
    },
  },
  config = function()
    local overseer = require("overseer")

    overseer.register_template({
      name = "Mypy",
      builder = function()
        local file = vim.fn.expand("%")
        local cmd = { "mypy", file }
        return {
          cmd = cmd,
          components = {
            "open_output",
            "base",
          },
        }
      end,
      priority = 10,
      condition = {
        filetype = "python",
      },
    })

    overseer.register_template({
      name = "Dmypy",
      builder = function()
        local file = vim.fn.expand("%")
        local cmd = { "dmypy", "check", file }
        return {
          cmd = cmd,
          components = {
            "open_output",
            "base",
          },
        }
      end,
      priority = 11,
      condition = {
        filetype = "python",
      },
    })

    overseer.register_template({
      name = "Pre-commit",
      builder = function()
        local cmd = { "pre-commit", "run" }
        return {
          cmd = cmd,
          components = {
            "open_output",
            "base",
          },
        }
      end,
      priority = 9,
    })

    overseer.setup({
      templates = {},
      task_list = {
        bindings = {
          ["<C-k>"] = false,
          ["<C-j>"] = false,
          ["<up>"] = "ScrollOutputUp",
          ["<down>"] = "ScrollOutputDown",
        },
      },
      component_aliases = {
        base = {
          {
            "on_output_quickfix",
            open_on_exit = "failure",
          },
          "on_result_diagnostics_trouble",
          "default",
        },
      },
      log = {
        {
          type = "echo",
          level = vim.log.levels.WARN,
        },
        {
          type = "file",
          filename = "overseer.log",
          level = vim.log.levels.DEBUG,
        },
      },
    })
  end,
}

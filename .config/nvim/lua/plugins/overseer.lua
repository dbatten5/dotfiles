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

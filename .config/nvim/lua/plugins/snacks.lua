return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      picker = {
        ui_select = true,
        previewers = {
          git = {
            args = { "--max-count 20" },
          },
        },
      },
    },
    quickfile = { enabled = true },
  },
  keys = {
    {
      "<space>ff",
      function()
        require("snacks").picker.files({ hidden = true })
      end,
      desc = "Find files",
    },
    {
      "<c-b>",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<space>fc",
      function()
        require("snacks").picker.commands()
      end,
      desc = "Find commands",
    },
    {
      "<space>fm",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Find keymaps",
    },
    {
      "<space>fw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Word search for visual selection",
      mode = { "n", "x" },
    },
    {
      "<space>fs",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Word search",
    },
    {
      "<space>fd",
      function()
        local cwd = vim.fn.expand("%:p:h")
        if vim.bo.filetype == "oil" then
          local oil_cwd = require("oil").get_current_dir()
          if oil_cwd then
            cwd = oil_cwd
          end
        end
        local opts = {
          cwd = cwd,
          prompt = "Find string relative to " .. require("utils.functions").truncateFilepath(cwd),
        }
        require("snacks").picker.grep(opts)
      end,
      desc = "Word search from current buffer (or Oil explorer)",
    },
    {
      "<space>f;",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command history",
    },
    {
      "<space>fb",
      function()
        require("snacks").picker.git_branches({
          preview = nil,
        })
      end,
      desc = "Git branches",
    },
    {
      "<space>fh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help tags",
    },
  },
}

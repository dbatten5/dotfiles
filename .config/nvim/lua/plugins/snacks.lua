return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    gitbrowse = { enabled = true },
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
    scratch = { enabled = true },
  },
  keys = {
    -- picker
    {
      "<space>ff",
      function()
        require("snacks").picker.files({ hidden = true })
      end,
      desc = "Find files",
    },
    {
      "<space>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Find buffers",
    },
    {
      "<space>fc",
      function()
        require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find config file",
    },
    {
      "<space>fp",
      function()
        require("snacks").picker.projects()
      end,
      desc = "Find projects",
    },
    {
      "<space>sb",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Search buffer lines",
    },
    {
      "<space>sB",
      function()
        require("snacks").picker.grep_buffers()
      end,
      desc = "Grep open buffers",
    },
    {
      "<space>sg",
      function()
        require("snacks").picker.grep()
      end,
      desc = "Grep",
    },
    {
      "<space>sw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Grep current word(s)",
      mode = { "n", "x" },
    },
    {
      "<space>s;",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Search command history",
    },
    {
      "<space>sc",
      function()
        require("snacks").picker.commands()
      end,
      desc = "Search commands",
    },
    {
      "<space>sh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Search help pages",
    },
    {
      "<space>sk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Search keymaps",
    },
    {
      "<space>sM",
      function()
        require("snacks").picker.man()
      end,
      desc = "Search man pages",
    },
    {
      "<space>sp",
      function()
        require("snacks").picker.lazy()
      end,
      desc = "Search for plugin spec",
    },
    {
      '<space>s"',
      function()
        require("snacks").picker.registers()
      end,
      desc = "Search through registers",
    },
    {
      "<space>sd",
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
          prompt = "Find string relative to " .. require("utils.functions").truncateFilepath(cwd) .. " > ",
        }
        require("snacks").picker.grep(opts)
      end,
      desc = "Grep from current directory (or Oil explorer)",
    },

    -- gitbrowse
    {
      "<leader>gl",
      function()
        require("snacks").gitbrowse.open({ branch = "master" })
      end,
      desc = "Open line(s) in GitHub",
      mode = { "n", "x" },
    },
    {
      "<leader>gL",
      function()
        require("snacks").gitbrowse.open({
          branch = "master",
          open = function(url)
            require("utils.functions").copyToSystemClipboard(url)
            vim.notify("GitHub URL copied to system clipboard", vim.log.levels.INFO)
          end,
        })
      end,
      desc = "Copy GitHub URL of current line(s) to clipboard",
      mode = { "n", "x" },
    },
    {
      "<leader>gf",
      function()
        require("snacks").gitbrowse.open({ what = "file", branch = "master" })
      end,
      desc = "Open file in GitHub",
      mode = { "n" },
    },
    {
      "<leader>gF",
      function()
        require("snacks").gitbrowse.open({
          branch = "master",
          what = "file",
          open = function(url)
            require("utils.functions").copyToSystemClipboard(url)
            vim.notify("GitHub URL copied to system clipboard", vim.log.levels.INFO)
          end,
        })
      end,
      desc = "Copy GitHub URL of current file to clipboard",
      mode = { "n" },
    },

    -- scratch
    {
      "<leader>.",
      function()
        require("snacks").scratch()
      end,
      desc = "Toggle Scratch Buffer",
    },
    {
      "<leader>S",
      function()
        require("snacks").scratch.select()
      end,
      desc = "Select Scratch Buffer",
    },
  },
}

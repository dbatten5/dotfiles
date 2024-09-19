return {
  "NeogitOrg/neogit",
  -- branch = "nightly",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = true,
  opts = {
    integrations = {
      telescope = true,
      diffview = true,
    },
    kind = "split",
  },
  keys = {
    {
      "<space>gg",
      function()
        local opts = {
          cwd = vim.g.neogit_root,
        }
        require("neogit").open(opts)
      end,
      desc = "Open Neogit",
    },
    {
      "<space>gb",
      function()
        require("neogit").open({ "branch" })
      end,
      desc = "Open Neogit branch",
    },
    {
      "<space>gc",
      function()
        require("neogit").open({ "commit" })
      end,
      desc = "Open Neogit commit",
    },
    {
      "<space>gu",
      function()
        require("neogit").open({ "push" })
      end,
      desc = "Open Neogit push",
    },
    {
      "<space>gp",
      function()
        require("neogit").open({ "pull" })
      end,
      desc = "Open Neogit pull",
    },
    {
      "<space>gl",
      function()
        require("neogit").open({ "log" })
      end,
      desc = "Open Neogit log",
    },
  },
}

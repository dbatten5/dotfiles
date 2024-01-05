return {
  "NeogitOrg/neogit",
  branch = "nightly",
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
    { "<space>g", "<cmd>Neogit<cr>", desc = "Open Neogit" },
  },
}

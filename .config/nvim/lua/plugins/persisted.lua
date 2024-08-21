return {
  "olimorris/persisted.nvim",
  lazy = false,
  keys = {
    {
      "<space>s",
      "<cmd>SessionLoad<cr>",
      desc = "Open the current session",
    },
  },
  opts = {
    autostart = true,
    use_git_branch = true,
    autoload = true,
  },
  config = function(_, opts)
    require("persisted").setup(opts)
  end,
}

return {
  "numToStr/Comment.nvim",
  lazy = true,
  keys = {
    { "<leader>c", mode = { "n", "v" }, desc = "Toggle comment" },
    { "gca", mode = { "n", "v" }, desc = "Add comment to the end of the line" },
    { "gco", mode = { "n", "v" }, desc = "Add comment to line below" },
    { "gcO", mode = { "n", "v" }, desc = "Add comment to line above" },
  },
  opts = {
    toggler = {
      line = "<leader>c",
    },
    opleader = {
      line = "<leader>c",
    },
    mappings = {
      basic = true,
      extras = true,
    },
  },
}

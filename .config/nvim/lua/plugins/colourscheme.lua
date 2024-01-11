return {
  "shaunsingh/nord.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.nord_italic = true
    vim.g.nord_bold = false
    vim.g.nord_borders = true
    vim.g.nord_uniform_diff_background = true
  end,
}

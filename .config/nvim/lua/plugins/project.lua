return {
  "ahmedkhalf/project.nvim",
  enabled = false,
  lazy = true,
  config = function()
    require("project_nvim").setup({
      manual_mode = true,
      detection_methods = { "pattern" },
      patterns = {
        "=src",
        ".git",
        ">plugins",
        ">snippets",
      },
    })
  end,
}

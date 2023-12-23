return {
  "ahmedkhalf/project.nvim",
  config = function()
    require("project_nvim").setup({
      patterns = {
        ".git",
        "Makefile",
        "package.json",
      },
    })
  end,
}

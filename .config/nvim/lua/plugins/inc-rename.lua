return {
  "smjonas/inc-rename.nvim",
  enabled = false,
  lazy = false,
  keys = {
    { "<leader>rn", ":IncRename ", desc = "Inc rename" },
  },
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "snacks",
    })
  end,
}

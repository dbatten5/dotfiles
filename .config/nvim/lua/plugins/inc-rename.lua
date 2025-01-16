return {
  "smjonas/inc-rename.nvim",
  keys = {
    { "<leader>rn", ":IncRename ", desc = "Inc rename" }
  },
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing",
    })
  end
}

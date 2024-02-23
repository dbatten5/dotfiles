return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ma",
      ":GrappleTag key=",
      desc = "Grapple tag a file",
    },
    {
      "<leader>mm",
      "<cmd>GrapplePopup tags<cr>",
      desc = "Open the Grapple tags popup",
    },
  },
}

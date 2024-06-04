return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ba",
      ":GrappleTag key=",
      desc = "Grapple tag a file",
    },
    {
      "<leader>bb",
      "<cmd>GrapplePopup tags<cr>",
      desc = "Open the Grapple tags popup",
    },
  },
}

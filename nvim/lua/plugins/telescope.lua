return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    { "<c-f>",      "<cmd>Telescope find_files<cr>",  desc = "Find files" },
    { "<c-b>",      "<cmd>Telescope buffers<cr>",     desc = "Find buffers" },
    { "<leader>fp", "<cmd>Telescope projects<cr>",    desc = "Projects" },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Word under cursor" },
    {
      "<leader>fs",
      '<cmd>lua require"telescope.builtin".grep_string{ shorten_path = true, word_match = "-w", only_sort_text = true, search = "" }<cr>',
      desc = "Word search",
    },
    { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "Command history" },
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      pickers = {
        find_files = {
          hidden = false,
        },
        buffers = {
          ignore_current_buffer = true,
          sort_lastused = true,
        },
      },
    })
    telescope.load_extension("fzf")
    telescope.load_extension("projects")
  end,
}

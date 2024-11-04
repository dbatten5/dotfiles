return {
  "nvim-treesitter/nvim-treesitter-context",
  lazy = false,
  keys = {
    {
      "<space>tsc",
      "<cmd>TSContextToggle<cr>",
      desc = "Toggle Treesitter Context",
    },
  },
  config = function()
    -- Set
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = function()
        vim.api.nvim_set_hl(0, "TreesitterContextBottom", {
          underline = true,
          sp = "Grey",
        })
      end,
    })
  end,
}

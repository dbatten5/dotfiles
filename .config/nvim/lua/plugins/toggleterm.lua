return {
  "akinsho/toggleterm.nvim",
  keys = { "<c-t>" },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-t>]],
    direction = "vertical",
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    local map = vim.keymap.set
    map("t", "<ESC>", "<c-\\><c-n>", { noremap = true })

    local trim_spaces = false
    vim.keymap.set("v", "<space>s", function()
      require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
    end)
  end,
}

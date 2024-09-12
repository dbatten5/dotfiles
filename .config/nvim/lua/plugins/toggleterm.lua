local set_opfunc = vim.fn[vim.api.nvim_exec(
  [[
  func s:set_opfunc(val)
    let &opfunc = a:val
  endfunc
  echon get(function('s:set_opfunc'), 'name')
]],
  true
)]

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

    -- Send a visual selection to the terminal
    vim.keymap.set("v", "<c-c>", function()
      require("toggleterm").exec_command("cmd=%cpaste")
      require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
      require("toggleterm").exec_command("cmd=--")
    end)

    -- Double the command to send current block to terminal
    vim.keymap.set("n", [[<c-c><c-c>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, trim_spaces, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("g@ip", "n", false)
    end)

    -- Add <c-c> as a motion mapping
    vim.keymap.set("n", [[<c-c>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").send_lines_to_terminal(motion_type, trim_spaces, { args = vim.v.count })
      end)
      vim.api.nvim_feedkeys("g@", "n", false)
    end)

    -- Send the whole file to the terminal
    vim.keymap.set("n", [[<leader><c-c>]], function()
      set_opfunc(function(motion_type)
        require("toggleterm").exec_command("cmd=%cpaste")
        require("toggleterm").send_lines_to_terminal(motion_type, trim_spaces, { args = vim.v.count })
        require("toggleterm").exec_command("cmd=--")
      end)
      vim.api.nvim_feedkeys("ggg@G''", "n", false)
    end)
  end,
}

local api = vim.api

-- go to last loc when opening a buffer
api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- set spelling utils for certain filetypes
api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "text", "latex", "NeogitCommitMessage" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en_gb"
    vim.keymap.set("i", "<c-i>", "<c-g>u<Esc>[s1z=`]a<c-g>u") -- correct spelling mistakes on the fly
  end,
})

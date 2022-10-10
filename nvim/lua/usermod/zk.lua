local zk = require("zk")
local commands = require("zk.commands")

zk.setup({
  -- can be "telescope", "fzf" or "select" (`vim.ui.select`)
  -- it's recommended to use "telescope" or "fzf"
  picker = "fzf",

  lsp = {
    -- `config` is passed to `vim.lsp.start_client(config)`
    config = {
      cmd = { "zk", "lsp" },
      name = "zk",
      -- on_attach = ...
      -- etc, see `:h vim.lsp.start_client()`
    },

    -- automatically attach buffers in a zk notebook that match the given filetypes
    auto_attach = {
      enabled = true,
      filetypes = { "markdown" },
    },
  },
})


local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "1 week ago" }, { title = "Zk Recents" }))

local opts = { noremap=true, silent=false }

-- Create a new note after asking for its title.
vim.api.nvim_set_keymap("n", "<space>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)

-- Open notes.
vim.api.nvim_set_keymap("n", "<space>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
vim.api.nvim_set_keymap("n", "<space>zt", "<Cmd>ZkTags<CR>", opts)

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap("n", "<space>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = vim.fn.input('Search: ') }<CR>", opts)
-- Search for the notes matching the current visual selection.
vim.api.nvim_set_keymap("v", "<space>zf", ":'<,'>ZkMatch<CR>", opts)

-- Run ZkRecents
vim.api.nvim_set_keymap("n", "<space>zr", "<Cmd>ZkRecents<CR>", opts)

local function yankName(options, picker_options)
  zk.pick_notes(options, picker_options, function(notes)
    local pos = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()

    if picker_options.multi_select == false then
      notes = { notes }
    end
    for _, note in ipairs(notes) do
      local nline = line:sub(0, pos) .. "[" .. note.title  .. "]" .. "(" .. note.path:sub(1,-6) .. ")" .. line:sub(pos + 1)
      vim.api.nvim_set_current_line(nline)
    end
  end)
end

commands.add("ZkInsertLink", function(options) yankName(options, { title = "ZkInsertLink" }) end)

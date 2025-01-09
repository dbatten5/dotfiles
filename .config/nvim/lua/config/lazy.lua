local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Remap comma as leader key
-- Must be before lazy
vim.g.mapleader = ","
-- vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<cr>")

require("lazy").setup({
  { import = "plugins" },
  { import = "plugins.lsp" },
  { import = "plugins.dap" },
}, {
  -- defaults = { lazy = true },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
  },
  change_detection = {
    enabled = false,
    notify = false,
  },
  debug = false,
  ui = {
    border = "rounded",
  },
  dev = {
    path = "~/projects/work",
  },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Remap comma as leader key
-- Must be before lazy
vim.g.mapleader = ","
-- vim.keymap.set("n", "<leader>ml", "<cmd>Lazy<cr>")

require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
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

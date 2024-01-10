local function init()
  -- autocmds
  require("config.autocmds")
  -- lazy.nvim
  require("config.lazy")
  -- options
  require("config.options")
  -- keymaps mappings (must be loaded after lazy)
  require("config.keymaps")
end

init()

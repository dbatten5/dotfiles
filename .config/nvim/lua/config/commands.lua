-- create a new plugin config file. takes the GitHub url of a plugin as the argument
vim.api.nvim_create_user_command("NewPlugin", function(opts)
  local url = opts.fargs[1]
  require("utils.functions").createNewPluginConfig(url)
end, {
  nargs = 1,
})

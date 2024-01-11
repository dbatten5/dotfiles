-- create a new plugin config file taking the GitHub url of a plugin as the argument
vim.api.nvim_create_user_command("NewPlugin", function(opts)
  local utils = require("utils.functions")
  local url = opts.fargs[1]

  local author, name = utils.parsePluginUrl(url)
  if not author or not name then
    vim.notify("Invalid plugin url", vim.log.levels.ERROR)
    return
  end

  local pluginPath = utils.createNewPluginConfig(author, name)

  if not pluginPath then
    return
  end

  vim.notify("Successfully created config file for " .. name, vim.log.levels.INFO)

  utils.promptYesNo("Do you want to open the config file?", function()
    vim.cmd("edit " .. pluginPath)
  end)
end, {
  nargs = 1,
})

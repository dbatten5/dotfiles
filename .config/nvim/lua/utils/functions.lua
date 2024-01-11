local M = {}

-- Truncate a filepath to a specified number of parts
--@param filepath the filepath to truncate
--@param numParts the number of parts to keep from the end of the filepath
--@return a joined string of the truncated filepath
M.truncateFilepath = function(filepath, numParts)
  numParts = numParts or 3 -- Set default value to 3 if not provided
  local paths = {}

  for path in filepath:gmatch("[^/]+") do
    table.insert(paths, path)
  end

  local numPaths = #paths

  local lastPaths = {}
  if numPaths >= numParts then
    for i = numPaths - numParts + 1, numPaths do
      table.insert(lastPaths, paths[i])
    end
  else
    lastPaths = paths
  end

  return ".../" .. table.concat(lastPaths, "/") .. "/"
end

-- Prompt for a yes or no answer and run the callback if yes
--@param message the message to display in the prompt
--@param callback the call to run if the user selects yes
M.promptYesNo = function(message, callback)
  local choice = vim.fn.confirm(message, "&Yes\n&No", 2)

  if choice == 1 then
    callback()
  end
end

-- Create a a new lazy.nvim plugin config file from a github url
--@param pluginUrl the github url of the plugin
M.createNewPluginConfig = function(pluginUrl)
  local _, _, pluginAuthor, pluginName = pluginUrl:find("([^/]+)/([^/]+)$")

  local strippedPluginName = pluginName:match("^(.-)%.")
  local cleanedName = strippedPluginName or pluginName

  local pluginPath = os.getenv("HOME") .. "/.config/nvim/lua/plugins/" .. cleanedName .. ".lua"

  local pluginConfigFile = io.open(pluginPath, "r")
  if pluginConfigFile then
    vim.notify("Config for " .. pluginName .. " already exists - not overwriting", vim.log.levels.WARN)
    pluginConfigFile:close()
    return
  end

  local template = [[
return {
  "]] .. pluginAuthor .. "/" .. pluginName .. [[",
}]]

  local newPluginConfigFile, err = io.open(pluginPath, "w")

  if not newPluginConfigFile then
    vim.notify("Error creating config file: " .. err, vim.log.levels.WARN)
    return
  end

  newPluginConfigFile:write(template)
  newPluginConfigFile:close()

  vim.notify("Successfully created config file for " .. pluginName, vim.log.levels.INFO)

  M.promptYesNo("Do you want to open the config file?", function()
    vim.cmd("edit " .. pluginPath)
  end)
end

return M

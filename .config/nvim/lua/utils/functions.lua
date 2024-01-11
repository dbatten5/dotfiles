local M = {}

-- trunacate a filepath to a specified number of parts
M.truncateFilepath = function(filepath, numParts)
  numParts = numParts or 3 -- Set default value to 3 if not provided
  local paths = {}

  -- Split the filepath into individual paths
  for path in filepath:gmatch("[^/]+") do
    table.insert(paths, path)
  end

  local numPaths = #paths

  -- Get the specified number of paths from the end
  local lastPaths = {}
  if numPaths >= numParts then
    for i = numPaths - numParts + 1, numPaths do
      table.insert(lastPaths, paths[i])
    end
  else
    lastPaths = paths
  end

  -- Join the last paths into a string using slashes
  local truncatedFilepath = table.concat(lastPaths, "/")

  return ".../" .. truncatedFilepath .. "/"
end

-- prompt for a yes or no answer and run the callback if yes
M.promptYesNo = function(message, callback)
  local choice = vim.fn.confirm(message, "&Yes\n&No", 2)

  if choice == 1 then
    callback()
  end
end

-- create a new plugin config file from a github url
M.newPlugin = function(pluginUrl)
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

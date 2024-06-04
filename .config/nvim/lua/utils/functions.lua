local M = {}

-- Set a keymap
--@param mode mode to set the keymaps
--@param lhs trigger to expand
--@param rhs mapped operation
--@param opts optional options
M.setKeymap = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Swap a pair of  keymaps
--@param a keymap to swap with b
--@param b keymap to swap with a
--@param mode mode to set the keymaps, default to normal mode
M.swapKeymaps = function(a, b, mode)
  mode = mode or "n"
  M.setKeymap(mode, a, b)
  M.setKeymap(mode, b, a)
end

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

-- Return the author and plugin name from a plugin github url
--@param pluginUrl the full github url of the plugin
--@return the author and plugin name
M.parsePluginUrl = function(pluginUrl)
  local _, _, pluginAuthor, pluginName = pluginUrl:find("([^/]+)/([^/]+)$")
  return pluginAuthor, pluginName
end

-- Create a new lazy.nvim plugin config file for a plugin
--@param pluginAuthor the plugin author
--@param pluginName the plugin name
--@returns the path to the new plugin config file
M.createNewPluginConfig = function(pluginAuthor, pluginName)
  local strippedPluginName = pluginName:match("^(.-)%.")
  local cleanedName = strippedPluginName or pluginName

  local pluginConfigPath = os.getenv("HOME") .. "/.config/nvim/lua/plugins/" .. cleanedName .. ".lua"

  local pluginConfigFile = io.open(pluginConfigPath, "r")
  if pluginConfigFile then
    vim.notify("Config for " .. pluginName .. " already exists - not overwriting", vim.log.levels.WARN)
    pluginConfigFile:close()
    return
  end

  local template = [[
return {
  "]] .. pluginAuthor .. "/" .. pluginName .. [[",
}]]

  local newPluginConfigFile, err = io.open(pluginConfigPath, "w")

  if not newPluginConfigFile then
    vim.notify("Error creating config file: " .. err, vim.log.levels.WARN)
    return
  end

  newPluginConfigFile:write(template)
  newPluginConfigFile:close()

  return pluginConfigPath
end

-- Copy some text to the system clipboard
--@param text the text to copy
M.copyToSystemClipboard = function(text)
  vim.fn.setreg("+", text)
end

-- Open a file in GitHub
--@param the file path to open in GitHub
M.openFileInGitHub = function(fp)
  vim.fn.system("gh browse " .. fp)
end

return M

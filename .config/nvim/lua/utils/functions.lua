local M = {}

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

return M

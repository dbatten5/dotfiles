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

vim.api.nvim_create_user_command("GitBranchFilesToQF", function()
  -- Get repo root
  local repo_root = require("utils.git").get_repo_root()
  if not repo_root or repo_root == "" then
    vim.notify("Not in a git repository", vim.log.levels.ERROR)
    return
  end

  -- Get changed files (relative to repo root)
  local files = require("utils.git").get_changed_files_of_current_branch()
  if #files == 0 then
    vim.notify("No changed files in current branch", vim.log.levels.INFO)
    return
  end

  local qf_items = {}
  for _, file in ipairs(files) do
    table.insert(qf_items, {
      filename = file, -- absolute path
      lnum = 1,
      col = 1,
      text = "Changed in branch",
    })
  end

  vim.fn.setqflist({}, "r", {
    title = "Files changed in current git branch",
    items = qf_items,
  })

  vim.cmd("copen")
end, {})

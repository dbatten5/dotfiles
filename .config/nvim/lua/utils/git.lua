local M = {}

-- Get the path of the root of a git repo
--@return string the path of the root of the git repo
function M.get_repo_root()
  local repo_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  return repo_root
end

-- Get changed files of the current branch against the default branch
--@return table<string> a table of the changed files
function M.get_changed_files_of_current_branch()
  local files = vim.fn.systemlist("git diff --relative origin/$(git defaultbranch) --name-only")
  return files
end

return M

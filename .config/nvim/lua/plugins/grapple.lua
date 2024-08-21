local function decodeUrlEncodedString(str)
  return str:gsub("%%(%x%x)", function(hex)
    return string.char(tonumber(hex, 16))
  end)
end

local function urlEncodeStr(str)
  local encoded = string.gsub(str, "([^%w])", function(match)
    return string.upper(string.format("%%%02x", string.byte(match)))
  end)

  return encoded
end

local function selectGrappleTag(grappleDir, callback)
  local grappleTags = vim.fn.glob(grappleDir .. "/*3A*.json", false, true)
  vim.ui.select(grappleTags, {
    prompt = "Select a branch to copy tags from",
    format_item = function(item)
      local tagName = vim.fn.fnamemodify(item, ":t")
      local decodedTagName = decodeUrlEncodedString(tagName)
      local _, branch_name = decodedTagName:match("(.+):(.+).json")
      return branch_name
    end,
  }, function(choice)
    if choice then
      local gitBranch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("%s+", "")
      local encodedGitBranch = urlEncodeStr(gitBranch)
      local newFilePath = choice:gsub("%%3A.-%.json", "%%3A" .. encodedGitBranch:gsub("%%", "%%%%")) .. ".json"
      local copyCommand = string.format("mv %s %s", vim.fn.shellescape(choice), vim.fn.shellescape(newFilePath))
      vim.fn.system(copyCommand)
      callback()
    else
      print("No branch selected.")
    end
  end)
end

return {
  "cbochs/grapple.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Grapple",
  keys = {
    {
      "<leader>ba",
      "<cmd>Grapple tag<cr>",
      desc = "Grapple tag a file",
    },
    {
      "<leader>bG",
      ":Grapple tag scope=git name=",
      desc = "Grapple tag a file with scope selection",
    },
    {
      "<leader>bb",
      "<cmd>Grapple toggle_tags<cr>",
      desc = "Open the Grapple tags popup",
    },
    {
      "<leader>bg",
      "<cmd>Grapple toggle_tags scope=git<cr>",
      desc = "Open the Grapple git tags popup",
    },
    {
      "<leader>bp",
      "<cmd>Grapple prune<cr>",
      desc = "Prune tags",
    },
    {
      "<leader>bc",
      function()
        local settings = require("grapple.settings"):new()
        local save_path = settings.save_path
        selectGrappleTag(save_path, require("grapple").prune)
      end,
      desc = "Copy the tags from another branch",
    },
  },
  opts = {
    scope = "git_branch",
    name_pos = "start",
    prune = "15d",
    win_opts = {
      width = 0.6,
      border = "rounded",
      title_pos = "left",
    },
  },
}

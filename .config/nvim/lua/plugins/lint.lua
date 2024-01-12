return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufEnter" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
  config = function()
    local default_linters = {
      python = { "ruff", "mypy" },
      zsh = { "shellcheck" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
    }
    local override_linters = vim.g.linters_by_ft or {}

    require("lint").linters_by_ft = vim.tbl_extend("force", default_linters, override_linters)
  end,
}

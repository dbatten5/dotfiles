return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      python = { "ruff", "mypy", "flake8" },
      zsh = { "shellcheck" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
  config = function(_, opts)
    require("lint").linters_by_ft = opts["linters_by_ft"]
  end,
}

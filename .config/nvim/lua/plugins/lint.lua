return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufWritePost", "BufEnter" },
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
      callback = function()
        require("lint").try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
  opts = {
    linters_by_ft = {
      bash = { "shellcheck" },
      htmldjango = { "djlint", "curlylint" },
      python = { "ruff", "mypy" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      typescript = { "eslint_d" },
    },
  },
  config = function(_, opts)
    local override_linters = vim.g.linters_by_ft or {}
    require("lint").linters_by_ft = vim.tbl_extend("force", opts.linters_by_ft, override_linters)
  end,
}

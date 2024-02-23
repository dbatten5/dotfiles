-- A format on save callback that sets all filetypes to autosave apart from
-- some specified types
--@param ignore_filetypes filetypes to ignore for autoformatting
local optimisticAutoFormat = function(ignore_filetypes)
  -- Disable autoformat on certain filetypes
  ignore_filetypes = ignore_filetypes or {}

  local _optimisticAutoFormat = function(bufnr)
    if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
      return
    end

    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end

    return { timeout_ms = 500, lsp_fallback = true }
  end

  return _optimisticAutoFormat
end

-- A format on save callback that sets all filetypes not to autosave apart from
-- some specified types
--@param always_format_on_save formatters to always run on save
--@param for_filetypes filetypes to run autoformatting on
local pessimisticAutoFormat = function(always_format_on_save, for_filetypes)
  always_format_on_save = always_format_on_save or {}
  for_filetypes = for_filetypes or {}

  local _pessimisticAutoFormat = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable autoformat for files in a certain path
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname:match("/node_modules/") then
      return
    end

    -- always run the following formatters on save
    local out = { timeout_ms = 500, lsp_fallback = true, formatters = always_format_on_save }

    -- Enable autoformat on certain filetypes
    if not vim.tbl_contains(for_filetypes, vim.bo[bufnr].filetype) then
      return out -- just the always_format_on_save
    end

    -- if we got here then we should enable auto_format for any enabled formatters
    out["formatters"] = nil -- remove explicit list of formatters to enable all formatters
    return out
  end

  return _pessimisticAutoFormat
end

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { "shfmt" },
      htmldjango = { "djlint" },
      json = { "prettier" },
      jsonc = { "prettier" },
      lua = { "stylua" },
      python = { "ruff", "black" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      yaml = { "prettier" },
      ["*"] = { "trim_whitespace", "codespell" },
    },
    auto_format = {
      optimistic = {
        ignore_filetypes = {},
      },
      pessmistic = {
        always_format_on_save = { "trim_whitespace", "codespell" },
        for_filetypes = { "lua", "json", "jsonc" },
      },
    },
  },
  config = function(_, opts)
    local override_formatters = vim.g.formatters_by_ft or {}
    local formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, override_formatters)

    require("conform").setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = optimisticAutoFormat(opts.auto_format.optimistic.ignore_filetypes),
    })

    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = "Disable autoformat-on-save",
      bang = true,
    })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = "Re-enable autoformat-on-save",
    })
  end,
}

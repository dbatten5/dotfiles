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
      mode = "",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "ruff", "black" },
      zsh = { "shfmt" },
      bash = { "shfmt" },
      sh = { "shfmt" },
      json = { "prettier" },
      jsonc = { "prettier" },
      ["*"] = { "trim_whitespace", "codespell" },
    },
  },
  init = function()
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
  config = function(_, opts)
    local override_formatters = vim.g.formatters_by_ft or {}
    local formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft, override_formatters)
    require("conform").setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return -- none at all
        end

        -- Disable autoformat for files in a certain path
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return -- none at all
        end

        -- always run the following formatters on save
        local always_format_on_save = { "trim_whitespace", "codespell" }

        local out = { timeout_ms = 500, lsp_fallback = true, formatters = always_format_on_save }

        -- Enable autoformat on certain filetypes
        local for_filetypes = { "lua", "json", "jsonc" }

        if not vim.tbl_contains(for_filetypes, vim.bo[bufnr].filetype) then
          return out -- just the always_format_on_save
        end

        -- if we got here then we should enable auto_format for any enabled formatters
        out["formatters"] = nil -- remove explicit list of formatters to enable all formatters
        return out
      end,
    })
  end,
}

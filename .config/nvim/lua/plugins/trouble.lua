return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xS",
      "<cmd>Trouble lsp_document_symbols toggle<cr>",
      desc = "LSP document symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
  },
  opts = {
    keys = {
      b = { -- toggle the active view filter
        action = function(view)
          view:filter({ buf = 0 }, { toggle = true })
        end,
        desc = "Toggle Current Buffer Filter",
      },
      s = { -- toggle the severity
        action = function(view)
          local f = view:get_filter("severity")
          local severity = ((f and f.filter.severity or 0) + 1) % 5
          view:filter({ severity = severity }, {
            id = "severity",
            template = "{hl:Title}Filter:{hl} {severity}",
            del = severity == 0,
          })
        end,
        desc = "Toggle Severity Filter",
      },
    },
    modes = {
      diagnostics = {
        filter = function(items)
          return vim.tbl_filter(function(item)
            -- Remove dmypy errors from the diagnostics list as they're just clutter
            return not item.message:find("Connection refused") and not item.message:find("Daemon crashed")
          end, items)
        end,
      },
      symbols = {
        format = "{kind_icon} {symbol.name:Normal}",
        win = {
          position = "right",
          size = 0.2,
        },
      },
      lsp_document_symbols = {
        format = "{kind_icon} {symbol.name:Normal}",
        win = {
          position = "right",
          size = 0.2,
        },
      },
      lsp = {
        win = {
          position = "right",
          size = 0.3,
        },
      },
    },
  },
}

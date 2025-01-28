return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    "theHamsta/nvim-dap-virtual-text",
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "typescript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "terraform",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        scope_incremental = "<cr>",
        node_incremental = "<tab>",
        node_decremental = "<s-tab>",
      },
    },
    endwise = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["am"] = "@function.outer",
          ["im"] = "@function.inner",
          ["a["] = "@class.outer",
          ["i["] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["ib"] = "@block.inner",
          ["ab"] = "@block.outer",
          ["ir"] = "@parameter.inner",
          ["ar"] = "@parameter.outer",
          ["it"] = "@return_type",
          ["at"] = "@return_type.outer",
          ["a="] = "@assignment.outer",
          ["i="] = "@assignment.inner",
          ["l="] = "@assignment.lhs",
          ["r="] = "@assignment.rhs",
          ["af"] = "@call.outer",
          ["if"] = "@call.inner",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>na"] = "@parameter.inner",
          ["<leader>nm"] = "@function.outer",
        },
        swap_previous = {
          ["<leader>pa"] = "@parameter.inner",
          ["<leader>pm"] = "@function.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
          ["]t"] = "@return_type",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
          ["[t"] = "@return_type",
        },
        goto_next = {
          -- ["]c"] = "@conditional.outer",
          -- ["]r"] = "@function.return_type",
        },
        goto_previous = {
          -- ["[c"] = "@conditional.outer",
          -- ["[r"] = "@function.return_type",
        },
      },
    },
  },
  config = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      ---@type table<string, boolean>
      local added = {}
      opts.ensure_installed = vim.tbl_filter(function(lang)
        if added[lang] then
          return false
        end
        added[lang] = true
        return true
      end, opts.ensure_installed)
    end
    require("nvim-treesitter.configs").setup(opts)
    require("nvim-ts-autotag").setup({
      aliases = {
        htmldjango = "html",
      },
    })
    -- require("nvim-dap-virtual-text").setup()
  end,
}

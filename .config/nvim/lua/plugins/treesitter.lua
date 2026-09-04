local parsers = {
  "bash",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "scala",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    "windwp/nvim-ts-autotag",
    "RRethy/nvim-treesitter-endwise",
    "theHamsta/nvim-dap-virtual-text",
  },
  config = function()
    local nvim_treesitter = require("nvim-treesitter")

    nvim_treesitter.setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    local patterns = {}
    for _, parser in ipairs(parsers) do
      nvim_treesitter.install(parser)
      local parse_patterns = vim.treesitter.language.get_filetypes(parser)
      for _, pp in ipairs(parse_patterns) do
        table.insert(patterns, pp)
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = patterns,
      callback = function(ev)
        vim.treesitter.start()
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- Incremental selection
    vim.keymap.set({ "n", "x" }, "<cr>", function()
      vim.treesitter.select("parent")
    end, { silent = true })
    vim.keymap.set("x", "<s-cr>", function()
      vim.treesitter.select("child")
    end, { silent = true })

    -- Textobject select
    local sel = require("nvim-treesitter-textobjects.select")
    local select_maps = {
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
      ["a="] = "@assignment.outer",
      ["i="] = "@assignment.inner",
      ["l="] = "@assignment.lhs",
      ["r="] = "@assignment.rhs",
      ["af"] = "@call.outer",
      ["if"] = "@call.inner",
    }
    for key, query in pairs(select_maps) do
      vim.keymap.set({ "x", "o" }, key, function()
        sel.select_textobject(query, "textobjects")
      end, { silent = true })
    end

    -- Swap
    vim.keymap.set("n", "<leader>na", function()
      sel.swap_next("@parameter.inner")
    end, { silent = true })
    vim.keymap.set("n", "<leader>nm", function()
      sel.swap_next("@function.outer")
    end, { silent = true })
    vim.keymap.set("n", "<leader>pa", function()
      sel.swap_previous("@parameter.inner")
    end, { silent = true })
    vim.keymap.set("n", "<leader>pm", function()
      sel.swap_previous("@function.outer")
    end, { silent = true })

    -- Move
    local move = require("nvim-treesitter-textobjects.move")
    local next_start = {
      ["]m"] = "@function.outer",
      ["]]"] = "@class.outer",
      ["]f"] = "@call.name",
    }
    local next_end = {
      ["]M"] = "@function.outer",
      ["]["] = "@class.outer",
      ["]t"] = "@return_type",
    }
    local prev_start = {
      ["[m"] = "@function.outer",
      ["[["] = "@class.outer",
      ["[f"] = "@call.name",
    }
    local prev_end = {
      ["[M"] = "@function.outer",
      ["[]"] = "@class.outer",
      ["[t"] = "@return_type",
      ["[i"] = "@import_statement",
    }
    for key, query in pairs(next_start) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_next_start(query)
      end, { silent = true })
    end
    for key, query in pairs(next_end) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_next_end(query)
      end, { silent = true })
    end
    for key, query in pairs(prev_start) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_previous_start(query)
      end, { silent = true })
    end
    for key, query in pairs(prev_end) do
      vim.keymap.set({ "n", "x", "o" }, key, function()
        move.goto_previous_end(query)
      end, { silent = true })
    end

    require("nvim-ts-autotag").setup({
      aliases = {
        htmldjango = "html",
      },
    })
  end,
}

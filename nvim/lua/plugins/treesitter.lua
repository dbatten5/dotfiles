return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
     'nvim-treesitter/nvim-treesitter-textobjects',
     'windwp/nvim-ts-autotag',
     'RRethy/nvim-treesitter-endwise',
  },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      'bash',
      'html',
      'javascript',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'regex',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'yaml',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<cr>',
        scope_incremental = '<cr>',
        node_incremental = '<tab>',
        node_decremental = '<s-tab>',
      },
    },
    endwise = {
      enable = true,
    },
    textobjects = {
      move = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['al'] = '@loop.outer',
          ['il'] = '@loop.inner',
          ['ib'] = '@block.inner',
          ['ab'] = '@block.outer',
          ['ir'] = '@parameter.inner',
          ['ar'] = '@parameter.outer',
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
  end,
}

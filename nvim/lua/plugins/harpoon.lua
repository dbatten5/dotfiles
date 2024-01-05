return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    "<leader>ha",
    "<leader>hh",
  },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --   local file_paths = {}
    --   for _, item in ipairs(harpoon_files.items) do
    --     table.insert(file_paths, item.value)
    --   end
    --
    --   require("telescope.pickers")
    --     .new({}, {
    --       prompt_title = "Harpoon",
    --       finder = require("telescope.finders").new_table({
    --         results = file_paths,
    --       }),
    --       previewer = conf.file_previewer({}),
    --       sorter = conf.generic_sorter({}),
    --     })
    --     :find()
    -- end

    local map = vim.keymap
    map.set("n", "<leader>ha", function()
      harpoon:list():append()
    end)
    map.set("n", "<leader>hh", function()
      -- toggle_telescope(harpoon:list())
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    map.set("n", "<leader>hi", function()
      harpoon:list():select(1)
    end)
    map.set("n", "<leader>hj", function()
      harpoon:list():select(2)
    end)
    map.set("n", "<leader>hk", function()
      harpoon:list():select(3)
    end)
    map.set("n", "<leader>hl", function()
      harpoon:list():select(4)
    end)
  end,
}

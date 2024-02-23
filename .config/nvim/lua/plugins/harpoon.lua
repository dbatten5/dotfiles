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
    local Job = require("plenary.job")

    local function get_os_command_output(cmd, cwd)
      if type(cmd) ~= "table" then
        return {}
      end
      local command = table.remove(cmd, 1)
      local stderr = {}
      local stdout, ret = Job:new({
        command = command,
        args = cmd,
        cwd = cwd,
        on_stderr = function(_, data)
          table.insert(stderr, data)
        end,
      }):sync()
      return stdout, ret, stderr
    end

    local harpoon = require("harpoon")

    harpoon:setup({
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
        key = function()
          local branch = get_os_command_output({
            "git",
            "rev-parse",
            "--abbrev-ref",
            "HEAD",
          })[1]

          if branch then
            return vim.loop.cwd() .. "-" .. branch
          else
            return vim.loop.cwd()
          end
        end,
      },
    })

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
    end, { desc = "Add to harpoon list" })
    map.set("n", "<leader>hh", function()
      -- toggle_telescope(harpoon:list())
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon menu" })
    map.set("n", "<leader>hi", function()
      harpoon:list():select(1)
    end, { desc = "Go to harpoon 1" })
    map.set("n", "<leader>hj", function()
      harpoon:list():select(2)
    end, { desc = "Go to harpoon 2" })
    map.set("n", "<leader>hk", function()
      harpoon:list():select(3)
    end, { desc = "Go to harpoon 3" })
    map.set("n", "<leader>hl", function()
      harpoon:list():select(4)
    end, { desc = "Go to harpoon 4" })
  end,
}

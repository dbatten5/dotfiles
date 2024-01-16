return {
  "zbirenbaum/copilot.lua",
  enabled = true,
  cmd = "Copilot",
  build = ":Copilot auth",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      copilot_node_command = os.getenv("HOME") .. "/.nvm/versions/node/v18.16.1/bin/node",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 1000,
        keymap = {
          accept = "<tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
    })
  end,
}

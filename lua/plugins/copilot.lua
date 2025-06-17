-- lua/plugins/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-J>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-X>",
        },
      },
      panel = { enabled = true },
      filetypes = {
        ["*"] = true,
      }
    })
  end,
}


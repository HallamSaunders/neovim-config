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

    -- Extra keybindings
    vim.keymap.set("i", "<C-L>", function()
      require("copilot.suggestion").accept_line()
    end, { desc = "Copilot accept just one line" })
  end,
}

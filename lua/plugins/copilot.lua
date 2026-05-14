return {
  "zbirenbaum/copilot.lua",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = false,
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
    vim.keymap.set("i", "<C-S>", function()
      local suggestion = require("copilot.suggestion")
      if suggestion.is_visible() then
        suggestion.dismiss()
      else
        suggestion.next()
      end
    end, { desc = "Manual Copilot trigger" })

    vim.keymap.set("i", "<C-f>", function()
      require("copilot.suggestion").accept_line()
    end, { desc = "Copilot accept just one line" })

    vim.keymap.set("i", "<C-L>", function()
      require("copilot.suggestion").accept_word()
    end, { desc = "Copilot accept just the next word" })
  end,
}

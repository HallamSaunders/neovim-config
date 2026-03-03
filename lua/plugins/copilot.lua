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
        --tex = false,
        markdown = false,
        plaintex = false,
      }
    })

    -- Extra keybindings
    vim.keymap.set("i", "<C-f>", function()
      require("copilot.suggestion").accept_line()
    end, { desc = "Copilot accept just one line" })

    vim.keymap.set("i", "<C-L>", function()
      require("copilot.suggestion").accept_word()
    end, { desc = "Copilot accept just the next word" })
  end,
}

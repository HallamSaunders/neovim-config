return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "TodoTrouble", "TodoTelescope", "TodoQuickFix" }, -- triggers lazy load
  event = "BufReadPost", -- loads early for keybinds
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous TODO comment" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Todo (Trouble)" },
    { "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo (Telescope)" },
  },
  opts = {}, -- use default config
}


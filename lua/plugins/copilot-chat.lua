return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- required Copilot engine
    { "nvim-lua/plenary.nvim" },  -- utilities
  },
  opts = {
    -- Example defaults you can tweak:
    window = {
      layout = "float", -- or "vertical", "horizontal"
      width = 0.4,      -- width of float window
      height = 0.6,     -- height of float window
    },
  },
  config = function(_, opts)
    require("CopilotChat").setup(opts)

    -- Keymaps
    vim.keymap.set("n", "<leader>cc", function()
      require("CopilotChat").toggle()
    end, { desc = "Toggle Copilot Chat" })

    vim.keymap.set("v", "<leader>ce", function()
      require("CopilotChat").explain()
    end, { desc = "Explain code with Copilot" })

    vim.keymap.set("v", "<leader>cf", function()
      require("CopilotChat").fix()
    end, { desc = "Fix code with Copilot" })

    vim.keymap.set("v", "<leader>cb", function()
      require("CopilotChat").buffer()
    end, { desc = "Discuss buffer with Copilot" })

    -- Highlights based on colour scheme
    vim.api.nvim_set_hl(0, "CopilotChatNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "CopilotChatBorder", { link = "FloatBorder" })
    vim.api.nvim_set_hl(0, "CopilotChatTitle", { link = "Title" })
    vim.api.nvim_set_hl(0, "CopilotChatQuestion", { link = "Question" })
    vim.api.nvim_set_hl(0, "CopilotChatAnswer", { link = "Normal" })
    vim.api.nvim_set_hl(0, "CopilotChatSelection", { link = "Visual" })
  end,
}

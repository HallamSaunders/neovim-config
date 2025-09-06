local M = {}

function M.setup()
  local colors = require("catppuccin.palettes").get_palette()

  -- Set highlights immediately (after plugins load)
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = colors.base, fg = colors.text })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = colors.surface2, bg = colors.base })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = colors.mantle, fg = colors.text })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = colors.surface1, fg = colors.text })
  vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = colors.peach, bold = true })
  vim.api.nvim_set_hl(0, "CopilotChatNormal", { bg = colors.base, fg = colors.text })
  vim.api.nvim_set_hl(0, "CopilotChatBorder", { fg = colors.surface2 })
end

return M

local M = {}

M.themes = {
  -- Custom
  {
    name = "Matugen",
    apply = function()
      -- Try to load the compiled Matugen file safely
      local status, matugen = pcall(require, "matugen-theme")
      if not status then
        vim.notify("Matugen colors not found! Generate them via CLI first.", vim.log.levels.WARN)
        return
      end

      local c = matugen.colors
      vim.o.termguicolors = true
      vim.g.colors_name = "matugen"

      local function hl(group, options)
        vim.api.nvim_set_hl(0, group, options)
      end

      -- Essential UI Groups
      hl("Normal", { fg = c.fg, bg = c.bg })
      hl("NormalFloat", { fg = c.fg, bg = c.bg_subtle })
      hl("CursorLine", { bg = c.bg_subtle })
      hl("LineNr", { fg = c.fg_muted })
      hl("CursorLineNr", { fg = c.primary, bold = true })
      hl("WinSeparator", { fg = c.border })
      hl("Visual", { bg = c.selection })
      hl("Pmenu", { fg = c.fg, bg = c.bg_subtle })
      hl("PmenuSel", { fg = c.bg, bg = c.primary, bold = true })

      -- Code/Syntax Highlights
      hl("Comment", { fg = c.fg_muted, italic = true })
      hl("Constant", { fg = c.tertiary })
      hl("String", { fg = c.secondary })
      hl("Identifier", { fg = c.primary })
      hl("Function", { fg = c.primary, bold = true })
      hl("Statement", { fg = c.primary })
      hl("Operator", { fg = c.fg })
      hl("Type", { fg = c.primary })
      hl("Special", { fg = c.secondary })

      -- Diagnostics (LSP)
      hl("DiagnosticError", { fg = c.error })
      hl("DiagnosticWarn", { fg = c.warning })
      hl("DiagnosticInfo", { fg = c.info })
      hl("DiagnosticHint", { fg = c.hint })
    end,
  },
  -- Matugen Transparent
  {
    name = "Matugen (Transparent)",
    apply = function()
      local status, matugen = pcall(require, "matugen-theme")
      if not status then
        vim.notify("Matugen colors not found!", vim.log.levels.WARN)
        return
      end

      local c = matugen.colors
      vim.o.termguicolors = true
      vim.g.colors_name = "matugen"

      local function hl(group, options)
        vim.api.nvim_set_hl(0, group, options)
      end

      -- Clear out standard panel backgrounds for absolute terminal transparency
      hl("Normal", { fg = c.fg, bg = "NONE" })
      hl("SignColumn", { bg = "NONE" })
      hl("FoldColumn", { bg = "NONE" })

      -- Floating windows & popups look best with a slight, subtle tint over the blur
      hl("NormalFloat", { fg = c.fg, bg = c.bg_subtle })
      hl("FloatBorder", { fg = c.border, bg = c.bg_subtle })

      -- UI Element highlights
      hl("CursorLine", { bg = c.bg_subtle })
      hl("LineNr", { fg = c.fg_muted, bg = "NONE" })
      hl("CursorLineNr", { fg = c.primary, bold = true, bg = "NONE" })
      hl("WinSeparator", { fg = c.border, bg = "NONE" })
      hl("Visual", { bg = c.selection })
      hl("Pmenu", { fg = c.fg, bg = c.bg_subtle })
      hl("PmenuSel", { fg = c.bg, bg = c.primary, bold = true })

      -- Code/Syntax Highlights
      hl("Comment", { fg = c.fg_muted, italic = true })
      hl("Constant", { fg = c.tertiary })
      hl("String", { fg = c.secondary })
      hl("Identifier", { fg = c.primary })
      hl("Function", { fg = c.primary, bold = true })
      hl("Statement", { fg = c.primary })
      hl("Operator", { fg = c.fg })
      hl("Type", { fg = c.primary })
      hl("Special", { fg = c.secondary })

      -- Diagnostics (LSP)
      hl("DiagnosticError", { fg = c.error, bg = "NONE" })
      hl("DiagnosticWarn", { fg = c.warning, bg = "NONE" })
      hl("DiagnosticInfo", { fg = c.info, bg = "NONE" })
      hl("DiagnosticHint", { fg = c.hint, bg = "NONE" })

      -- ======================================================================== --
      -- TROUBLE.NVIM TRANSPARENCY OVERRIDES                                      --
      -- ======================================================================== --
      hl("TroubleNormal", { bg = "NONE" })         -- Main Trouble window background
      hl("TroubleNormalNC", { bg = "NONE" })       -- Trouble window when out of focus
      hl("TroubleSignColumn", { bg = "NONE" })     -- Sidebar column for icons
      hl("TroubleFoldIcon", { fg = c.primary, bg = "NONE" })
      hl("TroubleText", { fg = c.fg, bg = "NONE" })

      -- Trouble UI Elements & Borders
      hl("TroubleBorder", { fg = c.border, bg = "NONE" })
      hl("TroubleHeader", { fg = c.primary, bold = true, bg = "NONE" })
      hl("TroubleLocation", { fg = c.fg_muted, bg = "NONE" })
      hl("TroubleSource", { fg = c.tertiary, bg = "NONE" })
      hl("TroubleCode", { fg = c.secondary, bg = "NONE" })

      -- Keep the selected line slightly tinted so you can still see what you're highlighting
      hl("TroubleSelected", { bg = c.selection })
    end,
  },

  -- Catppuccin
  {
    name = "Catppuccin Mocha",
    apply = function()
      require("catppuccin").setup({ flavour = "mocha", transparent_background = false })
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  {
    name = "Catppuccin Macchiato",
    apply = function()
      require("catppuccin").setup({ flavour = "macchiato", transparent_background = false })
      vim.cmd("colorscheme catppuccin-macchiato")
    end,
  },
  {
    name = "Catppuccin Frappe",
    apply = function()
      require("catppuccin").setup({ flavour = "frappe", transparent_background = false })
      vim.cmd("colorscheme catppuccin-frappe")
    end,
  },
  {
    name = "Catppuccin Latte",
    apply = function()
      require("catppuccin").setup({ flavour = "latte", transparent_background = false })
      vim.cmd("colorscheme catppuccin-latte")
    end,
  },

  -- Kanagawa
  {
    name = "Kanagawa Wave",
    apply = function()
      require("kanagawa").setup({ theme = "wave", transparent = false })
      vim.cmd("colorscheme kanagawa-wave")
    end,
  },
  {
    name = "Kanagawa Dragon",
    apply = function()
      require("kanagawa").setup({ theme = "dragon", transparent = false })
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    name = "Kanagawa Lotus",
    apply = function()
      require("kanagawa").setup({ theme = "lotus", transparent = false })
      vim.cmd("colorscheme kanagawa-lotus")
    end,
  },

  -- Nightfox
  {
    name = "Nightfox",
    apply = function()
      vim.cmd("colorscheme nightfox")
    end,
  },
  {
    name = "Dayfox",
    apply = function()
      vim.cmd("colorscheme dayfox")
    end,
  },
  {
    name = "Dawnfox",
    apply = function()
      vim.cmd("colorscheme dawnfox")
    end,
  },
  {
    name = "Duskfox",
    apply = function()
      vim.cmd("colorscheme duskfox")
    end,
  },
  {
    name = "Nordfox",
    apply = function()
      vim.cmd("colorscheme nordfox")
    end,
  },
  {
    name = "Terafox",
    apply = function()
      vim.cmd("colorscheme terafox")
    end,
  },
  {
    name = "Carbonfox",
    apply = function()
      vim.cmd("colorscheme carbonfox")
    end,
  },

  -- Tokyo Night
  {
    name = "Tokyo Night",
    apply = function()
      require("tokyonight").setup({ style = "night", transparent = false })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
  {
    name = "Tokyo Night Storm",
    apply = function()
      require("tokyonight").setup({ style = "storm", transparent = false })
      vim.cmd("colorscheme tokyonight-storm")
    end,
  },
  {
    name = "Tokyo Night Moon",
    apply = function()
      require("tokyonight").setup({ style = "moon", transparent = false })
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
  {
    name = "Tokyo Night Day",
    apply = function()
      require("tokyonight").setup({ style = "day", transparent = false })
      vim.cmd("colorscheme tokyonight-day")
    end,
  },

  -- Everforest
  {
    name = "Everforest Dark Hard",
    apply = function()
      vim.g.everforest_background = "hard"
      vim.o.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Everforest Dark Medium",
    apply = function()
      vim.g.everforest_background = "medium"
      vim.o.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Everforest Dark Soft",
    apply = function()
      vim.g.everforest_background = "soft"
      vim.o.background = "dark"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Everforest Light Hard",
    apply = function()
      vim.g.everforest_background = "hard"
      vim.o.background = "light"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Everforest Light Medium",
    apply = function()
      vim.g.everforest_background = "medium"
      vim.o.background = "light"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Everforest Light Soft",
    apply = function()
      vim.g.everforest_background = "soft"
      vim.o.background = "light"
      vim.cmd("colorscheme everforest")
    end,
  },
}

-- Persistence
local state_file = vim.fn.stdpath("data") .. "/theme.txt"

function M.save(name)
  local f = io.open(state_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

function M.load_saved()
  local f = io.open(state_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    for _, t in ipairs(M.themes) do
      if t.name == name then
        t.apply()
        return
      end
    end
  end
  -- Default fallback
  M.themes[1].apply()
end

function M.pick()
  local names = vim.tbl_map(function(t) return t.name end, M.themes)
  vim.ui.select(names, { prompt = "Select theme:" }, function(choice)
    if not choice then return end
    for _, t in ipairs(M.themes) do
      if t.name == choice then
        vim.cmd("highlight clear")
        vim.cmd("syntax reset")
        t.apply()
        M.save(t.name)
        return
      end
    end
  end)
end

function M.current_index()
  local f = io.open(state_file, "r")
  if f then
    local name = f:read("*l")
    f:close()
    for i, t in ipairs(M.themes) do
      if t.name == name then return i end
    end
  end
  return 1
end

function M.next()
  local idx = M.current_index()
  local next_idx = (idx % #M.themes) + 1
  local t = M.themes[next_idx]
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  t.apply()
  M.save(t.name)
  vim.notify("Theme: " .. t.name, vim.log.levels.INFO)
end

function M.prev()
  local idx = M.current_index()
  local prev_idx = ((idx - 2) % #M.themes) + 1
  local t = M.themes[prev_idx]
  vim.cmd("highlight clear")
  vim.cmd("syntax reset")
  t.apply()
  M.save(t.name)
  vim.notify("Theme: " .. t.name, vim.log.levels.INFO)
end

return M

local M = {}

M.themes = {
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

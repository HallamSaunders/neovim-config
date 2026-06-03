local M = {}

M.themes = {
  {
    name = "Carbonfox",
    apply = function()
      vim.cmd("colorscheme carbonfox")
    end,
  },
  {
    name = "Nightfox",
    apply = function()
      vim.cmd("colorscheme nightfox")
    end,
  },
  {
    name = "Dawnfox",
    apply = function()
      vim.cmd("colorscheme dawnfox")
    end,
  },
  {
    name = "Catppuccin Mocha",
    apply = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          indent_blankline = { enabled = true },
          nvimtree = true,
          telescope = true,
          treesitter = true,
          which_key = true,
        },
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
        },
        custom_highlights = function(colors)
          return {
            NormalFloat = { bg = colors.base },
            FloatBorder = { fg = colors.surface2 },
            Pmenu = { bg = colors.mantle, fg = colors.text },
            PmenuSel = { bg = colors.surface1, fg = colors.text },
          }
        end,
      })
      vim.cmd("colorscheme catppuccin-mocha")
    end,
  },
  {
    name = "Kanagawa Dragon",
    apply = function()
      require("kanagawa").setup({
        compile = true,
        undercurl = true,
        commentStyle = { italic = true },
        keywordStyle = { italic = true },
        theme = "dragon",
        overrides = function(colors)
          local theme = colors.theme
          return {
            NormalFloat = { bg = theme.ui.bg_p1 },
            FloatBorder = { fg = theme.ui.bg_p2 },
            Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_p1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = theme.ui.bg_p2 },
          }
        end,
      })
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
  {
    name = "Everforest",
    apply = function()
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = "hard"
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    name = "Flexoki Dark",
    apply = function()
      vim.g.flexoki_transparent = true
      vim.cmd("colorscheme flexoki-dark")
    end,
  },
}

-- Persistence file
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

return M

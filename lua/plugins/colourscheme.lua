--return {
--  'folke/tokyonight.nvim',
--  lazy = false,
--  priority = 1000,
--  config = function()
--    vim.cmd([[colorscheme tokyonight]])
--  end
--}

return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000, -- ensures it loads first
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        indent_blankline = true,
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
        which_key = true,
      },
      transparent_background = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      custom_highlights = function(colors)
        return {
          NormalFloat = { bg = colors.base },                    -- popup background
          FloatBorder = { fg = colors.surface2 },                -- border color
          Pmenu = { bg = colors.mantle, fg = colors.text },      -- cmp menu
          PmenuSel = { bg = colors.surface1, fg = colors.text }, -- selected item
        }
      end,
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}

--return {
--	"rebelot/kanagawa.nvim",
--	priority = 1000,
--	config = function()
--		require("kanagawa").setup({
--			theme = "wave", -- darkest variant
--			transparent = true, -- make background transparent
--			dimInactive = true, -- dim inactive window
--
--			integrations = {
--				cmp = true,                              -- enable nvim-cmp
--				gitsigns = true,                         -- enable gitsigns
--				nvimtree = true,                         -- enable nvim-tree
--				telescope = true,                        -- enable telescope
--				treesitter = true,                       -- enable treesitter
--				which_key = true,                        -- enable which-key
--				indent_blankline = { enabled = true, colored_indent_levels = true }, -- enable indent-blankline#
--			}
--		})
--		vim.cmd("colorscheme kanagawa")
--	end,
--}

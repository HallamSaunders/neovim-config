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
    })
    vim.cmd.colorscheme "catppuccin"
  end,
}

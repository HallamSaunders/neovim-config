return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "python", "javascript", "typescript", "lua", "html", "css", "json", "bash", "yaml", "markdown", "markdown_inline", "go", "rust" },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  }
}

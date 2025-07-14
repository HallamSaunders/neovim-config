return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
        view_options = {
            show_hidden = true,
        }
    })
    -- Example keymap to open Oil in the current directory
    vim.keymap.set("n", "-", "<CMD>oil<CR>", { desc = "Open parent directory" })
  end
}

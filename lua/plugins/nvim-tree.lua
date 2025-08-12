return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false,
      },
      view = {
        width = {
          min = 30,
          max = -1,
          padding = 1,
        },
        preserve_window_proportions = true,
      }
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>de", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

    -- Disable side scrolling
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "NvimTree",
      callback = function()
        vim.opt_local.wrap = false
        vim.opt_local.sidescroll = 0
        vim.opt_local.sidescrolloff = 0
      end,
    })
  end,
}

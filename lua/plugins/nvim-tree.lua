return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
        filters = {
            dotfiles = false,
        }	
    })
    vim.keymap.set("n", "<leader>de", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })  
  end,
}

return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "latexmk"
    vim.g.vimtex_compiler_latexmk = {
      options = {
        "-shell-escape",
      },
    }

    vim.g.vimtex_compiler_start_immediately = 1

    -- Keybindings
    vim.keymap.set("n", "<leader>cv", "<cmd>VimtexCompile<CR>", { desc = "Vimtex Compile" })
  end,
}

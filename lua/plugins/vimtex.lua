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

    --vim.api.nvim_create_autocmd("FileType", {
    --  pattern = "tex",
    --  callback = function()
        -- Start continuous compilation in the background
    --    vim.cmd("VimtexCompile")
    --  end,
    --})
  end,
}

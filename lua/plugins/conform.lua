return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        yml = { "prettier" },
        python = { "black" },
        tex = { "latexindent" },
        go = { "gofmt" }
      },
      formatters = {
        prettier = {
          command = vim.fn.getcwd() .. "/frontend/node_modules/.bin/prettier",
          args = { "--stdin-filepath", "$FILENAME" },
          cws = vim.fn.getcwd() .. "/frontend",
        },
        black = {
          command = "black",
          args = { "--quiet", "-" },
        },
        latexindent = {
          command = "latexindent",
          args = { "-l", "-m" },
          stdin = false,
        },
      },
    })
  end,
}

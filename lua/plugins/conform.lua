return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 1000,
        lsp_fallback = false,
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
          command = "npm",
          args = { "exec", "--", "prettier", "--stdin-filepath", "$FILENAME" },
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

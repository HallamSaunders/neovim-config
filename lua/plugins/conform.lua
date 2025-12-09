return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("conform").setup({
      format_on_save = {
        timeout_ms = 5000,
        lsp_fallback = false,
        lsp_format = "never",
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
        bib = { "latexindent" },
        go = { "gofmt" },
        rust = { "rustfmt" },
        svelte = { "prettier" },
      },
      formatters = {
        prettier = {
          command = "npm",
          args = { "exec", "--", "prettier", "--stdin-filepath", "$FILENAME" },
        },
        --prettier = {
        --  command = "prettier",
        --  args = { "--stdin-filepath", "$FILENAME" },
        --  cwd = require("conform.util").root_file({ "package.json", ".prettierrc" }),
        --},
        black = {
          command = "black",
          args = { "--quiet", "-" },
        },
        latexindent = {
          command = "latexindent",
          args = { "-l", "-m" },
          stdin = true,
        },
        gofmt = {
          command = "gofmt",
          args = {},
        },
        rustfmt = {
          command = "rustfmt",
          args = {},
          --stdin = true,
          -- Don't pass filename or it will format twice
          filename = true,
        },
      },
    })

    vim.api.nvim_create_user_command("Format", function()
      require("conform").format({ async = true })
    end, { desc = "Format current buffer" })
  end,
}

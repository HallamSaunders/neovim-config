return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    servers = {
      pyright = {},
      ts_ls = {},
      rust_analyzer = {},
      marksman = {},
      lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },
            },
          },
        },
      },
      bashls = {},
      yamlls = {},
      texlab = {
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-outdir=%OUTDIR%", "%INPUT%" },
              onSave = true,
            },
            forwardSearch = {
              executable = "zathura",
              args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
            formatterLineLength = 100
          }
        }
      }
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')

    for server, config in pairs(opts.servers) do
      lspconfig[server].setup(config)
    end

    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.py", "*.js", "*.ts", "*.rs", "*.md", "*.lua", "*.sh", "*.yaml", "*.tex" },
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })

    -- Show diagnostic in floating window with 250ms hold
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

    -- Keymaps
    vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap = true, silent = true })
  end,
}

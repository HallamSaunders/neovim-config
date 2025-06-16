return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig.util')
      
      lspconfig.pyright.setup{
        settings = {
          python = {
            pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
          }
        }
      }

      lspconfig.ts_ls.setup{}
      
      -- Rust (rust_analyser)
      lspconfig.rust_analyzer.setup {
        root_dir = util.root_pattern("Cargo.toml") or util.path.dirname,
      }

      -- Show diagnostic in floating window with 250ms hold
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

      -- Keymaps
      vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap=true, silent=true })
    end,
  }
}

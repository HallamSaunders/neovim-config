return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local util = require('lspconfig.util')

      -- Python (Pyright) for website's Django backend 
      lspconfig.pyright.setup {
        cmd = { "pyright-langserver", "--stdio" },
        root_dir = util.root_pattern("manage.py"), 
      }

      -- TypeScript/JavaScript (tsserver) for website frontend
      lspconfig.ts_ls.setup {
        cmd = { "typescript-language-server", "--stdio" },
        root_dir = util.root_pattern("package.json", "tsconfig.json"),
      }

      -- Show diagnostic in floating window with 250ms hold
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

      -- Keymaps
      vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap=true, silent=true })
    end,
  }
}

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
      gopls = {},
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')

    for server, config in pairs(opts.servers) do
      lspconfig[server].setup(config)
    end

    -- Show diagnostic in floating window with 250ms hold
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })]]

    -- Keymaps
    vim.keymap.set('n', 'K', vim.diagnostic.open_float, { noremap = true, silent = true })


    --      lspconfig.pyright.setup{
    --  settings = {
    --    python = {
    --      pythonPath = vim.fn.getcwd() .. '/.venv/bin/python',
    --    }
    --  }
    -- }

    --lspconfig.ts_ls.setup{}

    --lspconfig.rust_analyzer.setup {
    --  root_dir = util.root_pattern("Cargo.toml") or util.path.dirname,
    --}

    --lspconfig.markdown.setup{
    --  filetypes = { "markdown" },
    --  root_dir = util.root_pattern(".git", "README.md", "index.md"),
    --}

    --lspconfig.lua_ls.setup{
    --  settings = {
    --    Lua = {
    --      runtime = {
    --        version = 'LuaJIT',
    --      },
    --      diagnostics = {
    --        globals = { 'vim' },
    --      },
    --      workspace = {
    --        library = vim.api.nvim_get_runtime_file("", true),
    --        checkThirdParty = false,
    --      },
    --      telemetry = {
    --        enable = false,
    --      },
    --    }
    --  }
    --}

    --lspconfig.bashls.setup{
    --  cmd = { "bash-language-server", "start" },
    --  filetypes = { "sh", "bash" },
    --  root_dir = util.root_pattern(".git", ".bashrc", ".bash_profile", ".profile"),
    --}
  end,
}

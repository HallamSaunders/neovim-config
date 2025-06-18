return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "pyright", -- Python
          "ts_ls", -- TypeScript/JavaScript
          "rust_analyzer", -- Rust 
          "marksman", -- Markdown
          "lua_ls", -- Lua 
          "bashls", -- Bash
          "tailwindcss", -- Tailwind CSS
        },
      }
    end,
  },
}


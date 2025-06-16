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
        ensure_installed = { "pyright", "ts_ls", "rust_analyzer" },
      }
    end,
  },
}


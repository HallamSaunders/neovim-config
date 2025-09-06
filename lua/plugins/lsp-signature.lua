return {
  "ray-x/lsp_signature.nvim",
  event = "InsertEnter",
  config = function()
    require("lsp_signature").setup({
      bind = true,
      floating_window = true, -- show in floating window
      hint_enable = true,     -- virtual text hints
      handler_opts = { border = "rounded" },
    })
  end,
}

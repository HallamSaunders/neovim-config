return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async", -- required
  },
  config = function()
    -- Set Neovim fold options
    vim.o.foldcolumn = "1" -- show fold column
    vim.o.foldlevel = 99   -- keep folds open by default
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Setup ufo
    require("ufo").setup({
      provider_selector = function(_, filetype, _)
        -- Use Treesitter if available, fallback to indent
        return { "treesitter", "indent" }
      end,
    })

    -- Keymaps for convenience
    vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })

    -- Preview folded text under cursor
    vim.keymap.set("n", "zp", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- if not folded, fallback to normal hover (requires LSP)
        vim.lsp.buf.hover()
      end
    end, { desc = "Preview fold or LSP hover" })
  end,
}

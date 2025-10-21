-- Keymap example: map space to leader key
vim.g.mapleader = " "

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Cloning lazy.nvim...")
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Use lazy.nvim to manage plugins
require("lazy").setup("plugins", {
  concurrency = 5
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("highlights").setup()
  end,
})

-- Set GB English spell checking for .txt, .md, and .tex files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "txt", "md", "tex" },
  callback = function()
    vim.opt.spell = true
    vim.opt.spelllang = "en_gb"
  end,
})

vim.opt.number = true         -- show line numbers
vim.opt.relativenumber = true -- show relative line numbers
vim.opt.expandtab = true      -- use spaces instead of tabs
vim.opt.shiftwidth = 2        -- shift 2 spaces when tab
vim.opt.tabstop = 2           -- 1 tab == 2 spaces
vim.opt.smartindent = true    -- autoindent new lines
vim.opt.wrap = true           -- wrap long lines
vim.opt.linebreak = true      -- wrap at word boundaries
vim.opt.breakindent = true    -- indent wrapped lines
vim.opt.scrolloff = 8         -- keep 8 lines above/below cursor
vim.opt.sidescrolloff = 8     -- keep 8 columns left/right of cursor


-- Keymap: save file with <leader>w
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('i', 'nml', '<Esc>', { desc = "nml to Escape" })

-- See function signature in insert mode with Ctrl-k
vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

-- Hover to see documentation with K
vim.keymap.set('n', 'K', vim.lsp.buf.hover)


-- Set log level (commented out since deprecated)
--vim.lsp.set_log_level("error")

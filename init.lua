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
require("lazy").setup("plugins")

vim.opt.number = true           -- show line numbers
vim.opt.relativenumber = true   -- show relative line numbers
vim.opt.expandtab = true        -- use spaces instead of tabs
vim.opt.shiftwidth = 2          -- shift 2 spaces when tab
vim.opt.tabstop = 2             -- 1 tab == 2 spaces
vim.opt.smartindent = true      -- autoindent new lines
vim.opt.wrap = false            -- don't wrap long lines

-- Keymap: save file with <leader>w
vim.keymap.set('n', '<leader>w', ':w<CR>')

-- Set log level
vim.lsp.set_log_level("error")

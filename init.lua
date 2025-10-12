-- Define the leader key BEFORE loading lazy
vim.g.mapleader = " "

-- Set up lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Basic settings
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Load plugins
require("lazy").setup("plugins")

-- Load theme settings
require("theme")

-- Load autocmds
require("autocmds")

-- Load key mappings
require("mappings")
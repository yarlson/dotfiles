-- Core Neovim settings
local opt = vim.opt

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Editor settings
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.number = true
opt.relativenumber = true
opt.clipboard = 'unnamedplus'
opt.mouse = ''
opt.termguicolors = true
opt.laststatus = 3 
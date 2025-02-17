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
opt.fillchars = { eob = ' ' }
opt.list = true
opt.listchars = { tab = '▸ ', trail = '▸', extends = '❯', precedes = '❮' }
opt.undofile = true
opt.undodir = vim.fn.stdpath 'cache' .. '/undo'
opt.undolevels = 1000
opt.updatetime = 300
opt.shortmess:append 'c'

-- Search settings
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Folding settings
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.foldnestmax = 10

-- Indentation settings
opt.shiftround = true
opt.expandtab = true
opt.smarttab = true

-- Line wrapping settings
opt.wrap = false
opt.linebreak = true
opt.showbreak = '↳ '
opt.breakindent = true
opt.showmatch = true


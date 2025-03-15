-- Core Neovim settings
local opt = vim.opt

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Editor settings
local editor_opts = {
  autoindent = true,
  smartindent = true,
  tabstop = 4,
  shiftwidth = 4,
  number = true,
  relativenumber = true,
  clipboard = 'unnamedplus',
  mouse = '',
  termguicolors = true,
  laststatus = 3,
  fillchars = { eob = ' ' },
  list = true,
  listchars = { tab = '▸ ', trail = '▸', extends = '❯', precedes = '❮' },
  undofile = true,
  undodir = vim.fn.stdpath 'cache' .. '/undo',
  undolevels = 1000,
  updatetime = 300,
}

-- Apply editor settings
for k, v in pairs(editor_opts) do
  opt[k] = v
end

-- Append to shortmess to avoid "Pattern not found" messages
opt.shortmess:append 'c'

-- Search settings
local search_opts = {
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
}

-- Apply search settings
for k, v in pairs(search_opts) do
  opt[k] = v
end

-- Folding settings
local fold_opts = {
  foldmethod = 'indent',
  foldlevel = 99,
  foldnestmax = 10,
}

-- Apply folding settings
for k, v in pairs(fold_opts) do
  opt[k] = v
end

-- Indentation settings
local indent_opts = {
  shiftround = true,
  expandtab = true,
  smarttab = true,
}

-- Apply indentation settings
for k, v in pairs(indent_opts) do
  opt[k] = v
end

-- Line wrapping settings
local wrap_opts = {
  wrap = false,
  linebreak = true,
  showbreak = '↳ ',
  breakindent = true,
  showmatch = true,
}

-- Apply line wrapping settings
for k, v in pairs(wrap_opts) do
  opt[k] = v
end


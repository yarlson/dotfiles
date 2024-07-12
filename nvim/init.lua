vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.loaded_netrwPlugin = 0

vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '▏ ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.wrap = false

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '-', '<cmd>Oil --float<CR>', { desc = 'Open parent directory' })
vim.keymap.set({ 'n', 'v' }, '<C-\\>', '<cmd>ToggleTerm direction=float<CR>', { desc = 'Open terminal' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('yarlson-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = 'Dockerfile*',
  group = vim.api.nvim_create_augroup('yarlson-filetype-assignments', { clear = true }),
  callback = function()
    vim.bo.filetype = 'dockerfile'
  end,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  group = vim.api.nvim_create_augroup('yarlson-filetype-assignments', { clear = true }),
  callback = function()
    local filename = vim.fn.expand '%:p' -- Get the absolute path of the current file
    vim.cmd 'silent! write' -- Save the file silently
    vim.fn.system('goimports -w ' .. filename) -- Run goimports on the file
    vim.cmd 'silent! edit' -- Reload the file silently
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field

vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  'tpope/vim-sleuth',
  { 'numToStr/Comment.nvim', opts = {} },
  require 'yarlson.plugins.indent-line',
  require 'yarlson/plugins/autopairs',
  require 'yarlson/plugins/barbar',
  require 'yarlson/plugins/cmp',
  require 'yarlson/plugins/conform',
  require 'yarlson/plugins/debug',
  require 'yarlson/plugins/gitsigns',
  require 'yarlson/plugins/harpoon',
  require 'yarlson/plugins/lint',
  require 'yarlson/plugins/lspconfig',
  require 'yarlson/plugins/lualine',
  require 'yarlson/plugins/mini',
  require 'yarlson/plugins/kanagawa',
  require 'yarlson/plugins/oil',
  require 'yarlson/plugins/supermaven',
  require 'yarlson/plugins/telescope',
  require 'yarlson/plugins/todo-comments',
  require 'yarlson/plugins/toggleterm',
  require 'yarlson/plugins/treesitter',
  require 'yarlson/plugins/which-key',
}

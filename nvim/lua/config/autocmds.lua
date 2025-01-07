local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Format on save with Conform
local format_group = augroup('ConformFormatOnSave', { clear = true })
autocmd('BufWritePre', {
  group = format_group,
  callback = function()
    require('conform').format { async = false }
  end,
})

-- Set filetype for templ files
vim.filetype.add { extension = { templ = 'templ' } } 
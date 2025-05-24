local keymap = vim.keymap.set

-- Buffer navigation
-- Standard Neovim buffer nav (still useful)
keymap('n', '<C-l>', function()
  vim.cmd.bnext()
end, { desc = 'Next Buffer (Standard)' })
keymap('n', '<C-h>', function()
  vim.cmd.bprevious()
end, { desc = 'Previous Buffer (Standard)' })

-- Bufferline specific navigation
keymap('n', '[b', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous Buffer (Bufferline)' })
keymap('n', ']b', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer (Bufferline)' })

-- Buffer closing
keymap('n', '<leader>bd', function()
  vim.cmd.Bdelete()
end, { desc = 'Delete Current Buffer (Bdelete)' }) -- Keep original Bdelete too

-- Jump to buffer by number (Bufferline)
for i = 1, 9 do
  keymap('n', '<leader>' .. i, function()
    vim.cmd('BufferLineGoToBuffer ' .. i)
  end, { desc = 'Go to Buffer ' .. i })
end

-- Project navigation (using Telescope which integrates with project.nvim)
-- Keymap <leader>fp is already defined in lua/plugins/telescope.lua for finding projects

-- Add other keymaps from your original init.lua here

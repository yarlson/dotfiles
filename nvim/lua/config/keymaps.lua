local keymap = vim.keymap.set

-- Buffer navigation
keymap('n', '<C-l>', function() vim.cmd.bnext() end, { desc = 'Next Buffer' })
keymap('n', '<C-h>', function() vim.cmd.bprevious() end, { desc = 'Previous Buffer' })

-- Buffer deletion
keymap('n', '<leader>bd', function() vim.cmd.Bdelete() end, {
  desc = 'Delete Current Buffer',
})

-- Add other keymaps from your original init.lua here
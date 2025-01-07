local keymap = vim.keymap.set

-- Buffer navigation
keymap('n', '<C-l>', ':bnext<CR>', { desc = 'Next Buffer', noremap = true, silent = true })
keymap('n', '<C-h>', ':bprevious<CR>', { desc = 'Previous Buffer', noremap = true, silent = true })

-- Buffer deletion
keymap('n', '<leader>bd', '<cmd>Bdelete<CR>', {
  desc = 'Delete Current Buffer',
  noremap = true,
  silent = true,
})

-- Add other keymaps from your original init.lua here 
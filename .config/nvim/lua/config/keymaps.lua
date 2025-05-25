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

-- Infra specific keymaps
keymap('n', '<leader>dt', '<cmd>Telescope terraform_doc<CR>', { desc = 'Terraform Documentation' })
keymap('n', '<leader>dy', '<cmd>Telescope yaml_schema<CR>', { desc = 'YAML Schema Selector' })

-- REST client keymaps (for API testing)
keymap('n', '<leader>rr', '<Plug>RestNvim', { desc = 'Run REST request under cursor' })
keymap('n', '<leader>rp', '<Plug>RestNvimPreview', { desc = 'Preview REST request' })
keymap('n', '<leader>rl', '<Plug>RestNvimLast', { desc = 'Re-run last REST request' })

-- Git conflict resolution
keymap('n', '<leader>co', '<cmd>GitConflictChooseOurs<CR>', { desc = 'Choose Ours (Git Conflict)' })
keymap('n', '<leader>ct', '<cmd>GitConflictChooseTheirs<CR>', { desc = 'Choose Theirs (Git Conflict)' })
keymap('n', '<leader>cb', '<cmd>GitConflictChooseBoth<CR>', { desc = 'Choose Both (Git Conflict)' })
keymap('n', '<leader>c0', '<cmd>GitConflictChooseNone<CR>', { desc = 'Choose None (Git Conflict)' })
keymap('n', ']x', '<cmd>GitConflictNextConflict<CR>', { desc = 'Next Git Conflict' })
keymap('n', '[x', '<cmd>GitConflictPrevConflict<CR>', { desc = 'Previous Git Conflict' })

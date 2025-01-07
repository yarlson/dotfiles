return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then return ']h' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next Git Hunk' })

        map('n', '[h', function()
          if vim.wo.diff then return '[h' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'Previous Git Hunk' })

        -- Actions
        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>gb', function() gs.blame_line { full = true } end, { desc = 'Blame Line' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'Diff This' })
        map('n', '<leader>gD', function() gs.diffthis('~') end, { desc = 'Diff Against HEAD' })
        map('n', '<leader>gt', gs.toggle_deleted, { desc = 'Toggle Deleted Lines' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select Hunk' })
      end,
    },
  },
} 
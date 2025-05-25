return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead', 'BufNewFile' },
    opts = {
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        -- Create a helper function to set keymaps
        local function map(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- Navigation keymaps
        map('n', ']h', function()
          if vim.wo.diff then
            return ']h'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Next Git Hunk' })

        map('n', '[h', function()
          if vim.wo.diff then
            return '[h'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Previous Git Hunk' })

        -- Action keymaps - replace string commands with function calls
        map({ 'n', 'v' }, '<leader>gs', function()
          gs.stage_hunk()
        end, { desc = 'Stage Hunk' })
        map({ 'n', 'v' }, '<leader>gr', function()
          gs.reset_hunk()
        end, { desc = 'Reset Hunk' })
        map('n', '<leader>gS', gs.stage_buffer, { desc = 'Stage Buffer' })
        map('n', '<leader>gu', gs.undo_stage_hunk, { desc = 'Undo Stage Hunk' })
        map('n', '<leader>gR', gs.reset_buffer, { desc = 'Reset Buffer' })
        map('n', '<leader>gp', gs.preview_hunk, { desc = 'Preview Hunk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = true }
        end, { desc = 'Blame Line' })
        map('n', '<leader>gd', gs.diffthis, { desc = 'Diff This' })
        map('n', '<leader>gD', function()
          gs.diffthis '~'
        end, { desc = 'Diff Against HEAD' })
        map('n', '<leader>gt', gs.toggle_deleted, { desc = 'Toggle Deleted Lines' })

        -- Text object - replace command string with function call
        map({ 'o', 'x' }, 'ih', function()
          gs.select_hunk()
        end, { desc = 'Select Hunk' })
      end,
      signs = {
        add = { text = '│' },
        change = { text = '│' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
    },
  },
  -- Magit-like Git interface with Neogit
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('neogit').setup {
        integrations = { diffview = true },
      }
    end,
    keys = {
      {
        '<leader>gg',
        function()
          require('neogit').open()
        end,
        desc = 'Open Neogit',
      },
      {
        '<leader>gc',
        function()
          require('neogit').open { 'commit' }
        end,
        desc = 'Neogit Commit',
      },
    },
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup {
        default_mappings = true,
        default_commands = true,
        disable_diagnostics = false,
        list_opener = 'copen',
        highlights = {
          incoming = 'DiffAdd',
          current = 'DiffText',
        },
      }
    end,
  },
}


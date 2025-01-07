return {
  -- Buffer deletion
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' },
  },

  -- Which-key for keybinding help
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- Comment.nvim for easy commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },

  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 15,
        open_mapping = [[<c-\>]],
        direction = 'horizontal',
      }
      vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { desc = 'Toggle Terminal' })
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 30,
          side = 'left',
        },
        renderer = {
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_cwd = true,
        },
      }
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
      vim.keymap.set('n', '<C-w>e', function()
        local nvim_tree = require 'nvim-tree.api'
        local current_buf = vim.api.nvim_get_current_buf()
        local current_buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')

        if current_buf_ft == 'NvimTree' then
          vim.cmd 'wincmd p'
        else
          nvim_tree.tree.focus()
        end
      end, { desc = 'Focus NvimTree' })
    end,
  },
} 
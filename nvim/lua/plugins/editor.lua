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
      vim.keymap.set('n', '<leader>t', function()
        require('toggleterm').toggle()
      end, { desc = 'Toggle Terminal' })
    end,
  },

  -- File explorer (Neo-tree)
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    config = function()
      require('neo-tree').setup {
        close_if_last_window = true,
        popup_border_style = 'rounded',
        enable_git_status = true,
        enable_diagnostics = true,
        window = {
          position = 'left',
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
        },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_hidden = true,
          },
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
        },
        default_component_configs = {
          indent = {
            padding = 0,
          },
        },
      }

      vim.keymap.set('n', '<leader>e', function()
        require('neo-tree.command').execute { toggle = true }
      end, { desc = 'Toggle File Explorer (Neo-tree)' })

      vim.keymap.set('n', '<C-w>e', function()
        local current_buf = vim.api.nvim_get_current_buf()
        local current_buf_ft = vim.api.nvim_buf_get_option(current_buf, 'filetype')
        if current_buf_ft == 'neo-tree' then
          vim.cmd 'wincmd p'
        else
          vim.cmd 'Neotree focus'
        end
      end, { desc = 'Focus File Explorer (Neo-tree)' })
    end,
  },

  -- Faster navigation between frequently used files with Harpoon
  {
    'ThePrimeagen/harpoon',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('harpoon').setup {}
    end,
    keys = {
      {
        '<leader>ha',
        function()
          require('harpoon.mark').add_file()
        end,
        desc = 'Mark File (Harpoon)',
      },
      {
        '<leader>hh',
        function()
          require('harpoon.ui').toggle_quick_menu()
        end,
        desc = 'Harpoon Menu',
      },
      {
        '<leader>h1',
        function()
          require('harpoon.ui').nav_file(1)
        end,
        desc = 'Go to Harpoon File 1',
      },
      {
        '<leader>h2',
        function()
          require('harpoon.ui').nav_file(2)
        end,
        desc = 'Go to Harpoon File 2',
      },
      {
        '<leader>h3',
        function()
          require('harpoon.ui').nav_file(3)
        end,
        desc = 'Go to Harpoon File 3',
      },
      {
        '<leader>h4',
        function()
          require('harpoon.ui').nav_file(4)
        end,
        desc = 'Go to Harpoon File 4',
      },
    },
  },
}

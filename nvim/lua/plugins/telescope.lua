return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require 'telescope.actions'
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { '.git/' },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              i = {
                ['<C-d>'] = function(prompt_bufnr)
                  local actions = require 'telescope.actions'
                  local action_state = require 'telescope.actions.state'
                  local entry = action_state.get_selected_entry()
                  if entry then
                    require('bufdelete').bufdelete(entry.bufnr, true)
                  end
                  actions.close(prompt_bufnr)
                end,
              },
            },
          },
        },
        extensions = {
          projects = {
            base_dirs = {
              '~/home',
              '~/work',
            },
            hidden_files = true,
            theme = 'dropdown',
          },
        },
      }

      require('telescope').load_extension 'projects'

      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'List Buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
      vim.keymap.set('n', '<leader>fp', require('telescope').extensions.projects.projects, { desc = 'Find Projects' })
    end,
  },

  -- Project management
  {
    'ahmedkhalf/project.nvim',
    config = function()
      require('project_nvim').setup {
        detection_methods = { 'pattern', 'lsp' },
        patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
        show_hidden = true,
        silent_chdir = false,
        ignore_lsp = {},
        datapath = vim.fn.stdpath 'data',
      }
    end,
  },
}

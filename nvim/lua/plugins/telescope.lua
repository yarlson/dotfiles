return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Configure Telescope
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      local builtin = require('telescope.builtin')

      -- Setup the main telescope configuration
      telescope.setup {
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
                  local action_state = require('telescope.actions.state')
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

      -- Load extensions
      telescope.load_extension('projects')

      -- Define keymaps in a separate section
      local telescope_keymaps = {
        { mode = 'n', key = '<leader>ff', action = builtin.find_files, desc = 'Find Files' },
        { mode = 'n', key = '<leader>fg', action = builtin.live_grep, desc = 'Live Grep' },
        { mode = 'n', key = '<leader>fb', action = builtin.buffers, desc = 'List Buffers' },
        { mode = 'n', key = '<leader>fh', action = builtin.help_tags, desc = 'Help Tags' },
        { mode = 'n', key = '<leader>fp', action = telescope.extensions.projects.projects, desc = 'Find Projects' },
      }

      -- Apply all keymaps
      for _, mapping in ipairs(telescope_keymaps) do
        vim.keymap.set(mapping.mode, mapping.key, mapping.action, { desc = mapping.desc })
      end
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
        datapath = vim.fn.stdpath('data'),
      }
    end,
  },
}

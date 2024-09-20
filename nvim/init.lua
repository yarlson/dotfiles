-- ===========================================
-- Neovim Configuration
-- ===========================================

-- -------------------------------
-- 1. Leader Key Configuration
-- -------------------------------
-- Set the global and local leader keys to space for easier keybinding shortcuts.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- -------------------------------
-- 2. Core Neovim Settings
-- -------------------------------
-- Basic editor settings for indentation, line numbers, and more.
vim.opt.autoindent = true -- Enable automatic indentation
vim.opt.smartindent = true -- Enable smart indentation
vim.opt.tabstop = 4 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.opt.number = true -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
vim.opt.mouse = '' -- Disable mouse support

-- Set global statusline as recommended by avante.nvim
vim.opt.laststatus = 3

-- -------------------------------
-- 3. Bootstrap lazy.nvim Plugin Manager
-- -------------------------------
-- Ensure that lazy.nvim is installed. If not, clone it from GitHub.
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- Use the stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath) -- Prepend lazy.nvim to runtime path

-- -------------------------------
-- 4. Plugin Setup with lazy.nvim
-- -------------------------------
-- Configure and initialize all plugins using lazy.nvim.
require('lazy').setup {

  -- ---------------------------------
  -- Plugin Management
  -- ---------------------------------
  {
    'folke/lazy.nvim',
    lazy = false, -- Load immediately
  },

  -- ---------------------------------
  -- Language Server Protocol (LSP) & Autocompletion
  -- ---------------------------------
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = { -- Automatically install these LSP servers and tools
        'gopls',
        'ts_ls',
        'eslint',
        'tailwindcss',
        'sqlls',
        'jsonls',
        'prettier',
        'gofmt',
        'sql-formatter',
        'delve',
        'pyright',
        'terraformls',
        'debugpy',
        'dockerls',
        'yamlls',
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = { -- Ensure these LSP servers are installed
        'gopls',
        'ts_ls',
        'eslint',
        'tailwindcss',
        'sqlls',
        'jsonls',
        'pyright',
        'terraformls',
        'dockerls',
        'yamlls',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'
      local cmp_nvim_lsp = require 'cmp_nvim_lsp'
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Define keybindings and behaviors when an LSP server attaches to a buffer
      local on_attach = function(client, bufnr)
        if client.name ~= 'eslint' then
          client.server_capabilities.document_formatting = true
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        -- LSP-related keybindings
        keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
        keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })
        keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
        keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
        keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
        keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
        keymap('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, { desc = 'Format Document' })

        -- DAP (Debug Adapter Protocol) keybindings if DAP is available
        local dap_ok, dap = pcall(require, 'dap')
        if dap_ok then
          keymap('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
          keymap('n', '<leader>dc', dap.continue, { desc = 'Continue Execution' })
          keymap('n', '<leader>ds', dap.step_over, { desc = 'Step Over' })
          keymap('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
          keymap('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
          keymap('n', '<leader>du', function()
            require('dapui').toggle()
          end, { desc = 'Toggle DAP UI' })
        end
      end

      -- List of LSP servers to configure
      local servers = {
        'gopls',
        'ts_ls',
        'eslint',
        'tailwindcss',
        'sqlls',
        'jsonls',
        'pyright',
        'terraformls',
        'dockerls',
        'yamlls',
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end

      -- Additional configurations for specific LSP servers (optional)
      lspconfig.yamlls.setup {
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
            },
            keyOrdering = false,
          },
        },
      }
    end,
  },

  -- ---------------------------------
  -- Autocompletion Plugins
  -- ---------------------------------
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip', -- Snippet engine
      'saadparwaiz1/cmp_luasnip', -- Snippet completions
      'hrsh7th/cmp-nvim-lsp', -- LSP completions
      'hrsh7th/cmp-buffer', -- Buffer completions
      'hrsh7th/cmp-path', -- Path completions
      'supermaven-inc/supermaven-nvim', -- Additional completion source
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Expand snippets using LuaSnip
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm { select = true }, -- Confirm selection
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = 'supermaven' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' }, -- Collection of snippets
    config = function()
      require('luasnip').setup {}
      require('luasnip.loaders.from_vscode').lazy_load() -- Load snippets from VSCode
    end,
  },

  -- ---------------------------------
  -- Treesitter for Enhanced Syntax Highlighting and Text Objects
  -- ---------------------------------
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate', -- Update Treesitter parsers
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects', -- Additional text objects
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { -- Languages to install parsers for
          'go',
          'typescript',
          'javascript',
          'json',
          'sql',
          'lua',
          'html',
          'css',
          'tsx',
          'python',
          'terraform',
          'dockerfile',
          'yaml',
        },
        auto_install = true, -- Automatically install missing parsers
        highlight = { enable = true }, -- Enable syntax highlighting
        indent = { enable = true }, -- Enable indentation based on syntax
        textobjects = { -- Define custom text objects
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aB'] = '@block.outer',
              ['iB'] = '@block.inner',
              ['aP'] = '@parameter.outer',
              ['iP'] = '@parameter.inner',
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- Set jumps in the jumplist
            goto_next_start = {
              [']f'] = '@function.outer',
              [']]'] = '@class.outer',
            },
            goto_next_end = {
              [']F'] = '@function.outer',
              [']['] = '@class.outer',
            },
            goto_previous_start = {
              ['[f'] = '@function.outer',
              ['[['] = '@class.outer',
            },
            goto_previous_end = {
              ['[F'] = '@function.outer',
              ['[]'] = '@class.outer',
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner',
            },
          },
        },
      }
    end,
  },

  -- ---------------------------------
  -- Code Formatting with Conform.nvim
  -- ---------------------------------
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters_by_ft = { -- Specify formatters for different filetypes
          lua = { 'stylua' },
          go = { 'gofmt' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          sql = { 'sql_formatter' },
          sh = { 'shfmt' },
          bash = { 'shfmt' },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier', 'yamlfmt' },
          markdown = { 'prettier' },
          python = { 'black' },
          terraform = { 'terraform_fmt' },
          dockerfile = { 'prettier', 'dockerfile_lint' },
          hcl = { 'terraform_fmt' },
        },
        format_on_save = { -- Automatically format files on save
          timeout_ms = 1000, -- Timeout for formatting
          lsp_fallback = true, -- Use LSP formatting if no formatter is specified
        },
      }

      -- Trigger Conform formatting before saving a buffer
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('ConformFormatOnSave', { clear = true }),
        callback = function()
          require('conform').format { async = false }
        end,
      })
    end,
  },

  -- ---------------------------------
  -- Debugging with nvim-dap
  -- ---------------------------------
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- Configure Delve for Go debugging
      dap.adapters.go = function(callback, config)
        local handle
        local pid_or_err
        local port = 38697
        handle, pid_or_err = vim.loop.spawn('dlv', {
          args = { 'dap', '-l', '127.0.0.1:' .. port },
          detached = true,
        }, function(code)
          handle:close()
          if code ~= 0 then
            print('Delve exited with code', code)
          end
        end)
        vim.defer_fn(function()
          callback { type = 'server', host = '127.0.0.1', port = port }
        end, 100)
      end

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug',
          request = 'launch',
          program = '${file}',
        },
      }

      dap.adapters.python = {
        type = 'executable',
        command = 'python',
        args = { '-m', 'debugpy.adapter' },
      }

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = 'launch',
          name = 'Launch file',

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = '${file}', -- This configuration will launch the current file if used.
          pythonPath = function()
            -- Use the virtual environment if available, else fallback to system python
            local venv_path = os.getenv 'VIRTUAL_ENV'
            if venv_path then
              return venv_path .. '/bin/python'
            else
              return '/usr/bin/python'
            end
          end,
        },
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()

      -- Automatically open DAP UI when debugging starts
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

      -- Automatically close DAP UI when debugging ends
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close()
      end
    end,
  },
  {
    'leoluz/nvim-dap-go',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-go').setup() -- Setup Go debugging integration
    end,
  },

  -- DAP for Python Enhancements
  {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup '~/.virtualenvs/debugpy/bin/python' -- Adjust the path to your debugpy installation
      require('dap-python').test_runner = 'pytest'
    end,
  },

  -- ---------------------------------
  -- Git Integration with gitsigns.nvim
  -- ---------------------------------
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

        -- Actions
        map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
        map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })
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

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select Hunk' })
      end,
    },
  },

  -- ---------------------------------
  -- Buffer Management Plugins
  -- ---------------------------------
  {
    'famiu/bufdelete.nvim',
    cmd = { 'Bdelete', 'Bwipeout' }, -- Load on specific commands
  },

  -- ---------------------------------
  -- Fuzzy Finder with Telescope
  -- ---------------------------------
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require 'telescope.actions'
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { '.git/' }, -- Ignore .git directory
          mappings = {
            i = {
              ['<C-u>'] = false, -- Disable default mappings
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
                    require('bufdelete').bufdelete(entry.bufnr, true) -- Delete buffer without closing Telescope
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

  -- ---------------------------------
  -- Project Management with project.nvim
  -- ---------------------------------
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

  -- ---------------------------------
  -- UI Enhancements
  -- ---------------------------------
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Ensure colorscheme loads first
    config = function()
      vim.cmd [[colorscheme tokyonight]] -- Set tokyonight as the colorscheme
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = { theme = 'tokyonight' }, -- Match colorscheme
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          numbers = 'buffer_id', -- Display buffer numbers
          diagnostics = 'nvim_lsp', -- Show LSP diagnostics
          offsets = { -- Adjust for file explorer
            {
              filetype = 'NvimTree',
              text = 'File Explorer',
              text_align = 'left',
              separator = true,
            },
          },
        },
      }
    end,
  },

  -- ---------------------------------
  -- Additional Quality of Life Plugins
  -- ---------------------------------
  {
    'folke/which-key.nvim',
    event = 'VeryLazy', -- Load on very lazy event
    opts = {},
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false } -- Show buffer-local keymaps
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup() -- Enable commenting functionality
    end,
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup {
        size = 20, -- Terminal window size
        open_mapping = [[<c-\>]], -- Keybinding to toggle terminal
        direction = 'float', -- Open terminal in a floating window
      }
      vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { desc = 'Toggle Terminal' })
    end,
  },

  -- ---------------------------------
  -- Supermaven Plugin Integration
  -- ---------------------------------
  {
    'supermaven-inc/supermaven-nvim',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('supermaven-nvim').setup {
        disable_inline_completion = false, -- Enable inline completions
      }
    end,
  },

  -- ---------------------------------
  -- File Explorer with nvim-tree.lua
  -- ---------------------------------
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('nvim-tree').setup {
        view = {
          width = 30, -- Width of the file explorer
          side = 'left', -- Position on the left
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
      -- Keybinding to toggle the file explorer
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle File Explorer' })
    end,
  },

  -- ---------------------------------
  -- Avante.nvim Integration
  -- ---------------------------------
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false,
    build = 'make',
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons',
      {
        -- Support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- Recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
    config = function()
      -- Ensure that avante_lib is loaded after the colorscheme
      require('avante_lib').load()

      require('avante').setup {
        provider = 'claude',
        auto_suggestions_provider = 'claude',
        claude = {
          endpoint = 'https://api.anthropic.com',
          model = 'claude-3-5-sonnet-20240620',
          temperature = 0,
          max_tokens = 4096,
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = false,
        },
        mappings = {
          diff = {
            ours = 'co',
            theirs = 'ct',
            all_theirs = 'ca',
            both = 'cb',
            cursor = 'cc',
            next = ']x',
            prev = '[x',
          },
          suggestion = {
            accept = '<M-l>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
          jump = {
            next = ']]',
            prev = '[[',
          },
          submit = {
            normal = '<CR>',
            insert = '<C-s>',
          },
          sidebar = {
            switch_windows = '<Tab>',
            reverse_switch_windows = '<S-Tab>',
          },
        },
        hints = { enabled = true },
        windows = {
          position = 'right', -- the position of the sidebar
          wrap = true, -- similar to vim.o.wrap
          width = 30, -- default % based on available width
          sidebar_header = {
            align = 'center', -- left, center, right for title
            rounded = true,
          },
        },
        highlights = {
          diff = {
            current = 'DiffText',
            incoming = 'DiffAdd',
          },
        },
        diff = {
          autojump = true,
          list_opener = 'copen',
        },
      }
    end,
  },
}

-- -------------------------------
-- 5. Buffer Deletion Keybindings
-- -------------------------------
-- Keybindings for managing buffers efficiently.

-- Delete the current buffer with <leader>bd
vim.keymap.set('n', '<leader>bd', '<cmd>Bdelete<CR>', {
  desc = 'Delete Current Buffer',
  noremap = true,
  silent = true,
})

-- Delete all buffers except NvimTree and open the file explorer with <leader>ba
vim.keymap.set('n', '<leader>ba', function()
  local bufdelete = require 'bufdelete'
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local buf_ft = vim.api.nvim_buf_get_option(buf, 'filetype')
      if buf_ft ~= 'NvimTree' then
        bufdelete.bufdelete(buf, true)
      end
    end
  end
end, {
  desc = 'Delete All Buffers Except NvimTree and Open File Explorer',
  noremap = true,
  silent = true,
})

-- -------------------------------
-- 6. Additional Configurations
-- -------------------------------
-- Configure diagnostics and other miscellaneous settings.

-- Load VSCode-style snippets
require('luasnip.loaders.from_vscode').lazy_load()

-- Diagnostic configurations for LSP
vim.diagnostic.config {
  virtual_text = true, -- Show virtual text for diagnostics
  signs = true, -- Show signs in the gutter
  update_in_insert = false, -- Don't update diagnostics in insert mode
  underline = true, -- Underline diagnostic text
  severity_sort = false, -- Do not sort diagnostics by severity
}

-- -------------------------------
-- End of Configuration
-- -------------------------------

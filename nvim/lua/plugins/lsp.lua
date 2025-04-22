return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'debugpy', -- Python debugging
        'delve', -- Go debugging
        'gofmt', -- Go formatting
        'prettier', -- Code formatting
        'pyright', -- Python LSP
        'sql-formatter',
        'zls', -- Zig LSP
        'intelephense', -- PHP LSP
        'stylua', -- Lua formatting
        'lua-language-server', -- Lua LSP
        'luacheck', -- Lua static analyzer
      },
    },
  },
  -- Add neodev.nvim for better Neovim Lua development
  {
    'folke/neodev.nvim',
    opts = {
      library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
      },
      setup_jsonls = true, -- configures jsonls to provide completion for project config
      lspconfig = true,
      pathStrict = true,
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
    opts = {
      ensure_installed = {
        'dockerls',
        'eslint',
        'gopls',
        'jsonls',
        'pyright',
        'sqlls',
        'tailwindcss',
        'templ',
        'terraformls',
        'ts_ls',
        'yamlls',
        'zls',
        'intelephense',
        'lua_ls', -- Lua language server
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'folke/neodev.nvim', -- Add dependency here too
    },
    config = function()
      -- Setup neodev first (must be called before lua_ls)
      require('neodev').setup {}

      local lspconfig = require 'lspconfig'
      local cmp_nvim_lsp = require 'cmp_nvim_lsp'
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Define LSP keymaps function
      local function setup_lsp_keymaps(client, bufnr)
        -- Create a local keymap function
        local function buf_keymap(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        -- LSP navigation keymaps
        buf_keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
        buf_keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Find References' })
        buf_keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
        buf_keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
        buf_keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
        buf_keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
        buf_keymap('n', '<leader>f', function()
          vim.lsp.buf.format { async = true }
        end, { desc = 'Format Document' })

        -- Debug keymaps (only if dap is available)
        local dap_ok, dap = pcall(require, 'dap')
        if dap_ok then
          buf_keymap('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
          buf_keymap('n', '<leader>dc', dap.continue, { desc = 'Continue Execution' })
          buf_keymap('n', '<leader>ds', dap.step_over, { desc = 'Step Over' })
          buf_keymap('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
          buf_keymap('n', '<leader>do', dap.step_out, { desc = 'Step Out' })
          buf_keymap('n', '<leader>du', function()
            require('dapui').toggle()
          end, { desc = 'Toggle DAP UI' })
        end
      end

      -- On attach function for LSP servers
      local on_attach = function(client, bufnr)
        if client.name ~= 'eslint' then
          client.server_capabilities.document_formatting = true
        end

        setup_lsp_keymaps(client, bufnr)
      end

      -- Server configuration table
      local server_configs = {
        dockerls = {},
        eslint = {},
        gopls = {},
        jsonls = {},
        pyright = {},
        sqlls = {},
        tailwindcss = {},
        templ = {},
        terraformls = {},
        ts_ls = {},
        intelephense = {},
        zls = {},
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
              },
              keyOrdering = false,
            },
          },
        },
        -- Add Lua Language Server with Neovim-specific configuration
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                -- Use LuaJIT for Neovim
                version = 'LuaJIT',
              },
              diagnostics = {
                -- Recognize the vim global
                globals = {
                  'vim',
                  -- Add other globals used in your config
                  'require',
                },
              },
              workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              -- Do not send telemetry data
              telemetry = {
                enable = false,
              },
              -- Format settings
              format = {
                enable = true,
                -- Use stylua rather than the built-in formatter
                defaultConfig = {
                  indent_style = 'space',
                  indent_size = '2',
                },
              },
            },
          },
        },
      }

      -- Set up each LSP server with its configuration
      for server_name, config in pairs(server_configs) do
        config.capabilities = capabilities
        config.on_attach = on_attach
        lspconfig[server_name].setup(config)
      end
    end,
  },
  -- Inline function signatures
  {
    'ray-x/lsp_signature.nvim',
    event = 'BufReadPre',
    opts = {
      bind = true,
      hint_prefix = '💡 ',
      handler_opts = {
        border = 'rounded',
      },
    },
    config = function(_, opts)
      require('lsp_signature').setup(opts)
    end,
  },
  -- Enhanced diagnostics UI with Trouble
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {}, -- Use default options
    keys = {
      {
        '<leader>xx',
        function()
          require('trouble').toggle()
        end,
        desc = 'Toggle Trouble (Diagnostics)',
      },
      {
        '<leader>xw',
        function()
          require('trouble').toggle 'workspace_diagnostics'
        end,
        desc = 'Workspace Diagnostics (Trouble)',
      },
      {
        '<leader>xd',
        function()
          require('trouble').toggle 'document_diagnostics'
        end,
        desc = 'Document Diagnostics (Trouble)',
      },
      {
        '<leader>xl',
        function()
          require('trouble').toggle 'loclist'
        end,
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xq',
        function()
          require('trouble').toggle 'quickfix'
        end,
        desc = 'Quickfix List (Trouble)',
      },
      {
        'gR',
        function()
          require('trouble').lsp_references()
        end,
        desc = 'LSP References (Trouble)',
      },
    },
  },
}

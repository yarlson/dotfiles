return {
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'debugpy',
        'delve',
        'gofmt',
        'prettier',
        'pyright',
        'sql-formatter',
        'zls',
      },
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
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
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
      }

      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end

      -- Additional configurations for specific LSP servers
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
} 
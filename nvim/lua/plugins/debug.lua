return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'

      -- Configure Go debugging
      local function setup_go_adapter()
        dap.adapters.go = function(callback, config)
          local handle
          local port = 38697
          handle, _ = vim.loop.spawn('dlv', {
            args = { 'dap', '-l', '127.0.0.1:' .. port },
            detached = true,
          }, function(code)
            handle:close()
            if code ~= 0 then
              vim.notify('Delve exited with code ' .. code, vim.log.levels.WARN)
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
      end

      -- Configure Python debugging
      local function setup_python_adapter()
        dap.adapters.python = {
          type = 'executable',
          command = 'python',
          args = { '-m', 'debugpy.adapter' },
        }

        dap.configurations.python = {
          {
            type = 'python',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            pythonPath = function()
              local venv_path = os.getenv 'VIRTUAL_ENV'
              if venv_path then
                return venv_path .. '/bin/python'
              else
                return '/usr/bin/python'
              end
            end,
          },
        }
      end

      -- Configure Zig debugging
      local function setup_zig_adapter()
        dap.adapters.lldb = {
          type = 'executable',
          command = '/usr/bin/lldb-vscode',
          name = 'lldb',
        }

        dap.configurations.zig = {
          {
            name = 'Launch Zig Program',
            type = 'lldb',
            request = 'launch',
            program = function()
              return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
            runInTerminal = false,
          },
        }
      end

      -- Set up all debug adapters
      setup_go_adapter()
      setup_python_adapter()
      setup_zig_adapter()
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Configure DAP UI
      dapui.setup {
        icons = { expanded = '▾', collapsed = '▸', current_frame = '▸' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
      }

      -- Configure auto-open/close behavior
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open()
      end

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
      require('dap-go').setup {}
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
      require('dap-python').test_runner = 'pytest'
    end,
  },
  -- Streamlined testing workflow with neotest
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python',
    },
    config = function()
      require('neotest').setup {
        adapters = {
          require 'neotest-python' {
            dap = { justMyCode = false },
            runner = 'pytest',
          },
          require 'neotest-go' {},
        },
        status = { virtual_text = true },
        output = { open_on_run = true },
      }
    end,
    keys = {
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        desc = 'Run File Tests (Neotest)',
      },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run Nearest Test (Neotest)',
      },
      {
        '<leader>ts',
        function()
          require('neotest').summary.toggle()
        end,
        desc = 'Toggle Test Summary (Neotest)',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open { enter = true }
        end,
        desc = 'Show Test Output (Neotest)',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        desc = 'Debug Nearest Test (Neotest)',
      },
    },
  },
}

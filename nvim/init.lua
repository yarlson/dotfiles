-- -------------------------------
-- 1. Leader Key Configuration
-- -------------------------------

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- -------------------------------
-- 2. Bootstrap lazy.nvim
-- -------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -------------------------------
-- 3. Plugin Setup with lazy.nvim
-- -------------------------------

require("lazy").setup({
  -- Plugin Manager
  {
    "folke/lazy.nvim",
    lazy = false,
  },

  -- LSP and Autocompletion
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls", "ts_ls", "eslint", "tailwindcss", "sqlls", "jsonls",
        "prettier", "gofmt", "sql-formatter",
        "delve",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "gopls", "ts_ls", "eslint", "tailwindcss", "sqlls", "jsonls",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')
      local cmp_nvim_lsp = require('cmp_nvim_lsp')
      local capabilities = cmp_nvim_lsp.default_capabilities()

      local on_attach = function(client, bufnr)
        if client.name ~= "eslint" then
          client.server_capabilities.document_formatting = true
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        local keymap = vim.keymap.set

        keymap('n', 'gd', vim.lsp.buf.definition,
          { desc = "Go to Definition", noremap = true, silent = true, buffer = bufnr })
        keymap('n', 'gr', vim.lsp.buf.references,
          { desc = "Find References", noremap = true, silent = true, buffer = bufnr })
        keymap('n', 'gi', vim.lsp.buf.implementation,
          { desc = "Go to Implementation", noremap = true, silent = true, buffer = bufnr })
        keymap('n', 'K', vim.lsp.buf.hover,
          { desc = "Hover Documentation", noremap = true, silent = true, buffer = bufnr })
        keymap('n', '<leader>rn', vim.lsp.buf.rename,
          { desc = "Rename Symbol", noremap = true, silent = true, buffer = bufnr })
        keymap('n', '<leader>ca', vim.lsp.buf.code_action,
          { desc = "Code Action", noremap = true, silent = true, buffer = bufnr })
        keymap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end,
          { desc = "Format Document", noremap = true, silent = true, buffer = bufnr })

        local dap_ok, dap = pcall(require, 'dap')
        if dap_ok then
          keymap('n', '<leader>db', dap.toggle_breakpoint,
            { desc = "Toggle Breakpoint", noremap = true, silent = true, buffer = bufnr })
          keymap('n', '<leader>dc', dap.continue,
            { desc = "Continue Execution", noremap = true, silent = true, buffer = bufnr })
          keymap('n', '<leader>ds', dap.step_over, { desc = "Step Over", noremap = true, silent = true, buffer = bufnr })
          keymap('n', '<leader>di', dap.step_into, { desc = "Step Into", noremap = true, silent = true, buffer = bufnr })
          keymap('n', '<leader>do', dap.step_out, { desc = "Step Out", noremap = true, silent = true, buffer = bufnr })
          keymap('n', '<leader>du', function() require('dapui').toggle() end,
            { desc = "Toggle DAP UI", noremap = true, silent = true, buffer = bufnr })
        end
      end

      local servers = { "gopls", "ts_ls", "eslint", "tailwindcss", "sqlls", "jsonls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = on_attach,
        }
      end
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "supermaven-inc/supermaven-nvim",
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = 'supermaven' },
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip").setup {}
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- Treesitter and Text Objects
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "go", "typescript", "javascript", "json", "sql", "lua", "html", "css", "tsx" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aB"] = "@block.outer",
              ["iB"] = "@block.inner",
              ["aP"] = "@parameter.outer",
              ["iP"] = "@parameter.inner",
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',
              ['@function.outer'] = 'V',
              ['@class.outer'] = '<c-v>',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
        },
      })
    end,
  },

  -- Null-ls for Formatting and Linting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.sql_formatter,
        },
        on_attach = function(client)
          if client.server_capabilities.document_formatting then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
              buffer = 0,
              callback = function()
                vim.lsp.buf.format({ bufnr = 0 })
              end,
            })
          end
        end,
      })
    end,
  },

  -- Debugging with nvim-dap
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      dap.adapters.go = function(callback, config)
        local handle
        local pid_or_err
        local port = 38697
        handle, pid_or_err = vim.loop.spawn("dlv", {
          args = { "dap", "-l", "127.0.0.1:" .. port },
          detached = true,
        }, function(code)
          handle:close()
          if code ~= 0 then
            print("Delve exited with code", code)
          end
        end)
        vim.defer_fn(
          function()
            callback({ type = "server", host = "127.0.0.1", port = port })
          end,
          100)
      end

      dap.configurations.go = {
        {
          type = "go",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require('dap'), require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
    end,
  },

  -- Git Integration
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- Fuzzy Finder with Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup {
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      }
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find Files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List Buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help Tags" })
    end,
  },

  -- UI Enhancements
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('lualine').setup {
        options = { theme = 'tokyonight' },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require('bufferline').setup {
        options = {
          numbers = "buffer_id",
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "NvimTree",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            }
          },
        }
      }
    end,
  },

  -- Additional Quality of Life Plugins
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup {
        size = 20,
        open_mapping = [[<c-\>]],
      }
      vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { noremap = true, silent = true, desc = "Toggle Terminal" })
    end,
  },

  -- Supermaven Plugin Integration
  {
    "supermaven-inc/supermaven-nvim",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require('supermaven-nvim').setup({
        disable_inline_completion = false
      })
    end,
  },

  -- -------------------------------
  -- 7. File Browser Plugin (nvim-tree.lua)
  -- -------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {
        view = {
          width = 30,
          side = 'left',
          -- auto_resize = true, -- Removed due to deprecation
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
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle File Explorer" })
    end,
  },
})

-- -------------------------------
-- 4. Additional Configurations
-- -------------------------------

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.number = true
vim.opt.relativenumber = true

require("luasnip.loaders.from_vscode").lazy_load()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
})

-- -------------------------------
-- 5. System Clipboard Configuration
-- -------------------------------

vim.opt.clipboard = "unnamedplus"

-- -------------------------------
-- 6. Disable Mouse
-- -------------------------------

vim.opt.mouse = ""

-- -------------------------------
-- End of Configuration
-- -------------------------------


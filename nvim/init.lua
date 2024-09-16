--[[
  init.lua
  Neovim configuration using lazy.nvim for a full-stack development environment.
  Technologies: Go, GORM, SQLite3/PostgreSQL, React/TypeScript, TailwindCSS, ShadcnUI
--]]

-- -------------------------------
-- 1. Leader Key Configuration
-- -------------------------------

-- Set leader key to space
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
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- -------------------------------
-- 3. Plugin Setup with lazy.nvim
-- -------------------------------

require("lazy").setup({
  -- -----------------------------
  -- Plugin Manager (lazy.nvim)
  -- -----------------------------
  {
    "folke/lazy.nvim",
    lazy = false, -- Make sure it's loaded during startup
  },

  -- -----------------------------
  -- LSP and Autocompletion
  -- -----------------------------
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSP Servers
        "gopls", "ts_ls", "eslint", "tailwindcss", "sqlls", "jsonls",
        -- Formatters
        "prettier", "gofmt", "sql-formatter",
        -- Debuggers
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

      local servers = { "gopls", "ts_ls", "eslint", "tailwindcss", "sqlls", "jsonls" }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
          on_attach = function(client, bufnr)
            -- Disable format on save for eslint and other linters to prevent conflicts
            if client.name ~= "eslint" then
              client.server_capabilities.document_formatting = true
            end
          end,
        }
      end
    end,
  },

  -- -----------------------------
  -- Autocompletion Plugins
  -- -----------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",                    -- Snippet engine
      "saadparwaiz1/cmp_luasnip",            -- Snippet completions
      "hrsh7th/cmp-nvim-lsp",                -- LSP completions
      "hrsh7th/cmp-buffer",                  -- Buffer completions
      "hrsh7th/cmp-path",                    -- Path completions
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

  -- -----------------------------
  -- Treesitter and Text Objects
  -- -----------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = { "go", "typescript", "javascript", "json", "sql", "lua", "html", "css", "tsx", "jsx", "tailwindcss" },
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
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
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
    },
  },

  -- -----------------------------
  -- Null-ls for Formatting and Linting
  -- -----------------------------
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

  -- -----------------------------
  -- Debugging with nvim-dap
  -- -----------------------------
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')
      -- Additional DAP configurations can be added here
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, -- Added nvim-neotest/nvim-nio
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
      -- Removed incorrect setup_dap_main()
    end,
  },

  -- -----------------------------
  -- Git Integration
  -- -----------------------------
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },

  -- -----------------------------
  -- Fuzzy Finder with Telescope
  -- -----------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require('telescope').setup{
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      }
    end,
  },

  -- -----------------------------
  -- UI Enhancements
  -- -----------------------------
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- Ensure this is loaded first
    config = function()
      vim.cmd[[colorscheme tokyonight]]
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
      require('bufferline').setup{
        options = {
          numbers = "buffer_id",
          diagnostics = "nvim_lsp",
          -- Additional options can be added here
        }
      }
    end,
  },

  -- -----------------------------
  -- TailwindCSS Colors
  -- -----------------------------
  {
    "roobert/tailwindcss-colors.nvim",
    config = function()
      require('tailwindcss-colors').setup()
    end,
  },

  -- -----------------------------
  -- Additional Quality of Life Plugins
  -- -----------------------------
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end,
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
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<c-\>]],
      }
    end,
  },
})

-- -------------------------------
-- 4. Additional Configurations
-- -------------------------------

-- Enable indentation based on Treesitter
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Ensure LuaSnip and friendly-snippets are loaded
require("luasnip.loaders.from_vscode").lazy_load()

-- Configure diagnostic signs and settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
})

-- -------------------------------
-- 5. External Dependencies Installation
-- -------------------------------

-- Most tools are managed by mason.nvim, but some require manual installation via npm or go.

-- To install npm-based tools:
-- Run the following commands in your terminal:
-- npm install -g eslint prettier tailwindcss

-- To install Go-based tools:
-- Ensure Go is installed, then run:
-- go install github.com/go-delve/delve/cmd/dlv@latest

-- -------------------------------
-- 6. Final Steps
-- -------------------------------

-- After saving this `init.lua`, open Neovim and run:
-- :Lazy sync
-- This will install all specified plugins and ensure dependencies are set up.

-- Restart Neovim to apply all configurations.

-- -------------------------------
-- End of Configuration
-- -------------------------------

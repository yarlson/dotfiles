return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'supermaven-inc/supermaven-nvim',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- Define completion mappings separately for clarity
      local cmp_mappings = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      }

      -- Define completion sources in priority order
      local cmp_sources = {
        { name = 'supermaven' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      }

      -- Configure cmp
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert(cmp_mappings),
        sources = cmp_sources,
        experimental = {
          ghost_text = true,
        },
      }

      -- Helper functions for toggling completion
      local function toggle_cmp(enable, is_global)
        if is_global then
          -- Toggle cmp globally
          local config = cmp.get_config()
          config.enabled = enable
          cmp.setup(config)
        else
          -- Toggle cmp for current buffer
          cmp.setup.buffer { enabled = enable }
        end
      end

      local function toggle_supermaven(enable)
        -- Use the official supermaven API
        local api = require 'supermaven-nvim.api'

        if enable then
          -- Start supermaven if it's not already running
          if not api.is_running() then
            api.start()
          end
        else
          -- Stop supermaven if it's running
          if api.is_running() then
            api.stop()
          end
        end
      end

      local function toggle_completion(enable, is_global)
        -- Handle supermaven (globally only, as it doesn't support per-buffer control)
        toggle_supermaven(enable)

        -- Handle cmp (globally or per-buffer)
        toggle_cmp(enable, is_global)

        local scope = is_global and 'globally for all buffers' or 'for this buffer'
        local state = enable and 'enabled' or 'disabled'
        vim.notify('Completion (cmp and supermaven) ' .. state .. ' ' .. scope .. '.', vim.log.levels.INFO)
      end

      -- Custom commands to toggle cmp and supermaven completion
      vim.api.nvim_create_user_command('Cmpoff', function()
        -- Disable cmp for this buffer only
        toggle_cmp(false, false)
        vim.notify('nvim-cmp completion disabled for this buffer.', vim.log.levels.INFO)
      end, { desc = 'Disable nvim-cmp completion for the current buffer', nargs = 0 })

      vim.api.nvim_create_user_command('Cmpon', function()
        -- Enable cmp for this buffer only
        toggle_cmp(true, false)
        vim.notify('nvim-cmp completion enabled for this buffer.', vim.log.levels.INFO)
      end, { desc = 'Enable nvim-cmp completion for the current buffer', nargs = 0 })

      vim.api.nvim_create_user_command('CmpoffAll', function()
        toggle_completion(false, true)
      end, { desc = 'Disable completion (cmp and supermaven) globally for all buffers', nargs = 0 })

      vim.api.nvim_create_user_command('CmponAll', function()
        toggle_completion(true, true)
      end, { desc = 'Enable completion (cmp and supermaven) globally for all buffers', nargs = 0 })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip').setup {}
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('supermaven-nvim').setup {
        disable_inline_completion = false,
      }
    end,
  },
}

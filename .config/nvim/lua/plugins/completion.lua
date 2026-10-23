return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
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
        ['<Esc>'] = cmp.mapping.abort(),
      }

      -- Define completion sources in priority order
      local cmp_sources = {
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
        window = {
          completion = {
            winhighlight = 'Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel',
            border = 'rounded',
          },
          documentation = {
            winhighlight = 'Normal:CmpDoc',
            border = 'rounded',
          },
        },
        experimental = {
          ghost_text = true,
        },
      }

      -- Create highlight groups for CMP with Fleet theme colors
      local palette = require 'fleet-theme.palette'

      -- Simple approach - match editor background
      vim.api.nvim_set_hl(0, 'Pmenu', { bg = palette.background, blend = 0 }) -- Match editor background
      vim.api.nvim_set_hl(0, 'PmenuSel', { bg = palette.selection, fg = palette.foreground, blend = 0 }) -- Selected item

      -- Set CMP specific highlights to match
      vim.api.nvim_set_hl(0, 'CmpPmenu', { bg = palette.background, fg = palette.foreground, blend = 0 })
      vim.api.nvim_set_hl(0, 'CmpSel', { bg = palette.selection, fg = palette.foreground, blend = 0 })
      vim.api.nvim_set_hl(0, 'CmpDoc', { bg = palette.background, fg = palette.foreground, blend = 0 })

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

      -- Custom commands to toggle cmp completion
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
        toggle_cmp(false, true)
        vim.notify('nvim-cmp completion disabled globally for all buffers.', vim.log.levels.INFO)
      end, { desc = 'Disable nvim-cmp completion globally for all buffers', nargs = 0 })

      vim.api.nvim_create_user_command('CmponAll', function()
        toggle_cmp(true, true)
        vim.notify('nvim-cmp completion enabled globally for all buffers.', vim.log.levels.INFO)
      end, { desc = 'Enable nvim-cmp completion globally for all buffers', nargs = 0 })

      -- Disable cmp for markdown files
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'markdown' },
        callback = function()
          toggle_cmp(false, false)
          vim.notify('nvim-cmp completion disabled for markdown file.', vim.log.levels.INFO)
        end,
      })
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
}

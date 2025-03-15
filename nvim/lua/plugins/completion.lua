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
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      -- Define completion mappings separately for clarity
      local cmp_mappings = {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
      cmp.setup({
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
      })
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = { 'rafamadriz/friendly-snippets' },
    config = function()
      require('luasnip').setup({})
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'supermaven-inc/supermaven-nvim',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('supermaven-nvim').setup({
        disable_inline_completion = false,
      })
    end,
  },
}
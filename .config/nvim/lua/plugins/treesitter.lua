return {
  -- Helm syntax support
  {
    'towolf/vim-helm',
    ft = 'helm',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vrischmann/tree-sitter-templ',
    },
    config = function()
      -- Define parsers to install
      local parsers = {
        'css',
        'dockerfile',
        'go',
        'html',
        'javascript',
        'json',
        'lua',
        'php',
        'python',
        'sql',
        'templ',
        'terraform',
        'tsx',
        'typescript',
        'yaml',
        'zig',
        'bash',
        'hcl',
        'groovy',
        'helm',
        'toml',
        'ini',
        'gitcommit',
        'git_rebase',
        'git_config',
      }

      -- Install parsers
      require('nvim-treesitter').install(parsers)

      -- Enable treesitter highlighting for all installed parsers
      for _, lang in ipairs(parsers) do
        vim.treesitter.language.register(lang, lang)
      end

      -- Enable highlighting and indentation globally
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ok = pcall(vim.treesitter.start, args.buf)
          if ok then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      -- Text objects selection keymaps
      local ts_select = require 'nvim-treesitter-textobjects.select'
      local ts_move = require 'nvim-treesitter-textobjects.move'
      local ts_swap = require 'nvim-treesitter-textobjects.swap'

      -- Selection keymaps
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        ts_select.select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        ts_select.select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        ts_select.select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        ts_select.select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select inner class' })
      vim.keymap.set({ 'x', 'o' }, 'aB', function()
        ts_select.select_textobject('@block.outer', 'textobjects')
      end, { desc = 'Select outer block' })
      vim.keymap.set({ 'x', 'o' }, 'iB', function()
        ts_select.select_textobject('@block.inner', 'textobjects')
      end, { desc = 'Select inner block' })
      vim.keymap.set({ 'x', 'o' }, 'aP', function()
        ts_select.select_textobject('@parameter.outer', 'textobjects')
      end, { desc = 'Select outer parameter' })
      vim.keymap.set({ 'x', 'o' }, 'iP', function()
        ts_select.select_textobject('@parameter.inner', 'textobjects')
      end, { desc = 'Select inner parameter' })

      -- Movement keymaps
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        ts_move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        ts_move.goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        ts_move.goto_next_end('@function.outer', 'textobjects')
      end, { desc = 'Next function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        ts_move.goto_next_end('@class.outer', 'textobjects')
      end, { desc = 'Next class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        ts_move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        ts_move.goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'Previous class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        ts_move.goto_previous_end('@function.outer', 'textobjects')
      end, { desc = 'Previous function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        ts_move.goto_previous_end('@class.outer', 'textobjects')
      end, { desc = 'Previous class end' })

      -- Swap keymaps
      vim.keymap.set('n', '<leader>a', function()
        ts_swap.swap_next('@parameter.inner', 'textobjects')
      end, { desc = 'Swap with next parameter' })
      vim.keymap.set('n', '<leader>A', function()
        ts_swap.swap_previous('@parameter.inner', 'textobjects')
      end, { desc = 'Swap with previous parameter' })
    end,
  },
}

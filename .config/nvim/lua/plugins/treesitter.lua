return {
  -- Helm syntax support
  {
    'towolf/vim-helm',
    ft = 'helm',
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vrischmann/tree-sitter-templ',
    },
    config = function()
      local yar_grammar_dir = '/Users/yaroslavk/git/yar-treesitter'
      local yar_parser_lib = yar_grammar_dir .. '/parser.so'

      local function register_yar_parser()
        if vim.fn.isdirectory(yar_grammar_dir) ~= 1 then
          return
        end

        vim.opt.runtimepath:append(yar_grammar_dir)
        if vim.fn.filereadable(yar_parser_lib) == 1 then
          vim.treesitter.language.add('yar', { path = yar_parser_lib })
        end
      end

      register_yar_parser()

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
      require('nvim-treesitter-textobjects').setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      -- Selection keymaps
      vim.keymap.set({ 'x', 'o' }, 'af', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
      end, { desc = 'Select outer function' })
      vim.keymap.set({ 'x', 'o' }, 'if', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
      end, { desc = 'Select inner function' })
      vim.keymap.set({ 'x', 'o' }, 'ac', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
      end, { desc = 'Select outer class' })
      vim.keymap.set({ 'x', 'o' }, 'ic', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
      end, { desc = 'Select inner class' })
      vim.keymap.set({ 'x', 'o' }, 'aB', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@block.outer', 'textobjects')
      end, { desc = 'Select outer block' })
      vim.keymap.set({ 'x', 'o' }, 'iB', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@block.inner', 'textobjects')
      end, { desc = 'Select inner block' })
      vim.keymap.set({ 'x', 'o' }, 'aP', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
      end, { desc = 'Select outer parameter' })
      vim.keymap.set({ 'x', 'o' }, 'iP', function()
        require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
      end, { desc = 'Select inner parameter' })

      -- Movement keymaps
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
        require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
      end, { desc = 'Next function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
        require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
      end, { desc = 'Next class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Previous function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
        require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'Previous class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
      end, { desc = 'Previous function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
        require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
      end, { desc = 'Previous class end' })

      -- Swap keymaps
      vim.keymap.set('n', '<leader>a', function()
        require('nvim-treesitter-textobjects.swap').swap_next '@parameter.inner'
      end, { desc = 'Swap with next parameter' })
      vim.keymap.set('n', '<leader>A', function()
        require('nvim-treesitter-textobjects.swap').swap_previous '@parameter.inner'
      end, { desc = 'Swap with previous parameter' })
    end,
  },
}

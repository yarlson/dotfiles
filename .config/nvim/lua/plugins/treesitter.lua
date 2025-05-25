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
        'gitignore',
        'gitcommit',
        'git_rebase',
        'git_config',
      }

      -- Text objects selection configuration
      local select_textobjects = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['aB'] = '@block.outer',
          ['iB'] = '@block.inner',
          ['aP'] = '@parameter.outer',
          ['iP'] = '@parameter.inner',
        },
        selection_modes = {
          ['@parameter.outer'] = 'v',
          ['@function.outer'] = 'V',
          ['@class.outer'] = '<c-v>',
        },
      }

      -- Text objects movement configuration
      local move_textobjects = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      }

      -- Text objects swap configuration
      local swap_textobjects = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      }

      -- Main treesitter configuration
      require('nvim-treesitter.configs').setup {
        ensure_installed = parsers,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = select_textobjects,
          move = move_textobjects,
          swap = swap_textobjects,
        },
      }
    end,
  },
}

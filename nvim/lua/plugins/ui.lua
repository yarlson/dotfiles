return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = { theme = 'tokyonight' },
      }
    end,
  },
  -- Add other UI plugins here
} 
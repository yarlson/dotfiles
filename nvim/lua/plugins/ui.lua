return {
  {
    'kepano/flexoki-neovim',
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme flexoki-dark]]
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup()
    end,
  },
}

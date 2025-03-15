return {
  {
    'kepano/flexoki-neovim',
    priority = 1000,
    config = function()
      vim.api.nvim_command('colorscheme flexoki-dark')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
      })
    end,
  },
}

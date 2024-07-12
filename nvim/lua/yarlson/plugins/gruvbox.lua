return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    init = function()
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'gruvbox'
      vim.cmd.hi 'Comment gui=none'
    end,
    opts = {
      contrast = 'hard',
    },
  },
}

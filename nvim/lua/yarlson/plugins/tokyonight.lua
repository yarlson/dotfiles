return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'tokyonight-night'
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'LineNr guibg=none'
      vim.cmd.highlight 'Comment gui=none'
    end,
  },
}

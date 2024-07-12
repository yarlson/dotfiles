return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    init = function()
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'kanagawa'
      vim.cmd.hi 'Comment gui=none'
      vim.cmd.hi 'LineNr guibg=none'
      vim.cmd.hi 'SignColumn guibg=none'
      vim.cmd.hi 'NvimTreeNormal guibg=none'
      vim.cmd.hi 'Normal guibg=none'
      vim.cmd.hi 'NormalFloat guibg=none'
      vim.cmd.hi 'NormalNC guibg=none'
    end,
    opts = {
      theme = 'dragon',
      contrast = 'hard',
    },
  },
}

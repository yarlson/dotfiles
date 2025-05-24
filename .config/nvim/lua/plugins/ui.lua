return {
  {
    'kepano/flexoki-neovim',
    priority = 1000,
    config = function()
      vim.api.nvim_command 'colorscheme flexoki-dark'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'auto',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    version = '*',
    opts = {
      options = {
        mode = 'buffers',
        numbers = 'ordinal',
        close_command = 'Bdelete! %d',
        right_mouse_command = 'Bdelete! %d',
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = ' '
          for e, n in pairs(diagnostics_dict) do
            local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
            s = s .. n .. sym
          end
          return s
        end,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            text_align = 'left',
            separator = true,
          },
        },
        separator_style = 'thin',
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
      },
    },
  },
}

local M = {
  "akinsho/bufferline.nvim",
  dependencies = {
    {
      "nvim-tree/nvim-web-devicons",
    },
  },
}

function M.config()
  require("bufferline").setup {
    options = {
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          text_align = "left",
        },
      },
      diagnostics = "nvim_lsp",
    },
  }
end

return M

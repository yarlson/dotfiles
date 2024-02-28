return {
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        -- Set the terminal direction to horizontal
        direction = "horizontal",
        -- Optionally, customize the horizontal split size
        size = 15, -- This sets the terminal to take up 20 lines at the bottom of your screen
        -- Other configuration options as per your preference
        open_mapping = [[<c-\>]], -- Example key mapping to open the terminal
        on_open = function(term)
          vim.cmd("startinsert!") -- Open the terminal with the cursor on the first line
          vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-\\>", "<C-\\><C-n>", { noremap = true })
        end,
      })
    end,
  },
}

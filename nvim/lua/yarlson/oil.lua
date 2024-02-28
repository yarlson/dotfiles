local wk = require("which-key")

wk.register({
  f = {
    e = { "<cmd>Oil<cr>", "Open Oil" },
  },
}, { prefix = "<leader>" })

vim.keymap.set("n", "<C-F1>", function()
  vim.cmd("vsplit | wincmd l")
  require("oil").open()
end, { silent = true })

return {
  {
    "stevearc/oil.nvim",
    opts = {
      show_hidden = true, -- Show hidden files
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}

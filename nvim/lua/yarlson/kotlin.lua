vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Jenkinsfile*",
  command = "set filetype=groovy",
})

return {
  {
    "udalov/kotlin-vim",
  },
}

return {
  {
    'stevearc/conform.nvim',
    config = function()
      require('conform').setup {
        formatters = {
          zigfmt = {
            command = 'zig',
            args = { 'fmt', '--stdin' },
            stdin = true,
          },
        },
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'gofmt' },
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          sql = { 'sql_formatter' },
          sh = { 'shfmt' },
          bash = { 'shfmt' },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          yaml = { 'prettier', 'yamlfmt' },
          markdown = { 'prettier' },
          python = { 'black' },
          terraform = { 'terraform_fmt' },
          dockerfile = { 'prettier', 'dockerfile_lint' },
          hcl = { 'terraform_fmt' },
          zig = { 'zigfmt' },
        },
        format_on_save = {
          timeout_ms = 1000,
          lsp_fallback = true,
        },
      }
    end,
  },
} 
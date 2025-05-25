return {
  {
    'stevearc/conform.nvim',
    config = function()
      -- Define custom formatters
      local custom_formatters = {
        zigfmt = {
          command = 'zig',
          args = { 'fmt', '--stdin' },
          stdin = true,
        },
        php_cs_fixer = {
          command = 'php-cs-fixer',
          args = { 'fix', '--using-cache=no', '--quiet', '--format=json', '--' },
          stdin = false,
        },
        -- DevOps formatters
        terragrunt_fmt = {
          command = 'terragrunt',
          args = { 'hclfmt', '--terragrunt-hclfmt-file', '$FILENAME' },
          stdin = false,
        },
        ansible_lint = {
          command = 'ansible-lint',
          args = { '--fix', '$FILENAME' },
          stdin = false,
        },
      }

      -- Define formatters by filetype
      local formatters_by_ft = {
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
        php = { 'php_cs_fixer' },
        -- DevOps specific
        ['yaml.ansible'] = { 'ansible_lint' },
        ['yaml.gitlab'] = { 'prettier' },
        ['yaml.github'] = { 'prettier' },
        ['yaml.docker-compose'] = { 'prettier' },
        ['yaml.kubernetes'] = { 'prettier' },
        terragrunt = { 'terragrunt_fmt' },
        helm = { 'prettier' },
      }

      -- Define format on save options
      local format_on_save_opts = {
        timeout_ms = 1000,
        lsp_fallback = true,
      }

      -- Configure conform
      require('conform').setup {
        formatters = custom_formatters,
        formatters_by_ft = formatters_by_ft,
        format_on_save = format_on_save_opts,
      }
    end,
  },
}

-- Define autocommands with Neovim's native API
local function create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    local augroup = vim.api.nvim_create_augroup(group_name, { clear = true })
    for _, def in ipairs(definition) do
      local opts = def.opts or {}
      opts.group = augroup
      vim.api.nvim_create_autocmd(def.event, opts)
    end
  end
end

-- Define autocommands
create_augroups {
  -- Format on save with Conform
  ConformFormatOnSave = {
    {
      event = 'BufWritePre',
      opts = {
        callback = function()
          require('conform').format { async = false }
        end,
      },
    },
  },
  -- Open Neo-tree on entering a directory
  NeoTreeOpenOnStart = {
    {
      event = 'VimEnter',
      opts = {
        callback = function()
          -- Always open Neo-tree on startup
          vim.schedule(function()
            require('neo-tree.command').execute { action = 'show' } -- Use show to ensure it opens
          end)
        end,
        desc = 'Open Neo-tree on VimEnter',
      },
    },
  },
  InfraSettings = {
    {
      event = 'FileType',
      opts = {
        pattern = { 'terraform', 'terragrunt', 'hcl' },
        callback = function()
          vim.opt_local.commentstring = '# %s'
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
        end,
        desc = 'Terraform/HCL settings',
      },
    },
    {
      event = 'FileType',
      opts = {
        pattern = { 'yaml', 'yaml.*' },
        callback = function()
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          vim.opt_local.expandtab = true
          vim.opt_local.foldmethod = 'indent'
          vim.opt_local.foldlevel = 99
        end,
        desc = 'YAML settings',
      },
    },
    {
      event = 'FileType',
      opts = {
        pattern = { 'groovy' },
        callback = function()
          vim.opt_local.commentstring = '// %s'
          vim.opt_local.tabstop = 4
          vim.opt_local.shiftwidth = 4
          vim.opt_local.expandtab = true
        end,
        desc = 'Groovy/Jenkinsfile settings',
      },
    },
  },
}

-- Set filetype for templ files
vim.filetype.add { extension = { templ = 'templ' } }

-- Infra file type detection
vim.filetype.add {
  extension = {
    hcl = 'terraform',
    tf = 'terraform',
    tfvars = 'terraform',
    tfstate = 'json',
  },
  filename = {
    ['terragrunt.hcl'] = 'terragrunt',
    ['Jenkinsfile'] = 'groovy',
    ['.gitlab-ci.yml'] = 'yaml.gitlab',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['Chart.yaml'] = 'yaml.helm',
    ['values.yaml'] = 'yaml.helm',
    ['kustomization.yaml'] = 'yaml.kubernetes',
    ['kustomization.yml'] = 'yaml.kubernetes',
  },
  pattern = {
    ['.*%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',
    ['.*%.github/workflows/.*%.ya?ml'] = 'yaml.github',
    ['.*playbook.*%.ya?ml'] = 'yaml.ansible',
    ['.*site%.ya?ml'] = 'yaml.ansible',
    ['.*%.k8s%.ya?ml'] = 'yaml.kubernetes',
    ['.*%.kubernetes%.ya?ml'] = 'yaml.kubernetes',
  },
}

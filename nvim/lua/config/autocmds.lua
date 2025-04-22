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
}

-- Set filetype for templ files
vim.filetype.add { extension = { templ = 'templ' } }

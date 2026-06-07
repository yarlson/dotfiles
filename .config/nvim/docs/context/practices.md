# Practices

## Plugin Organization

- One Lua file per functional area in `lua/plugins/` (completion, debug, editor, formatting, git, lsp, telescope, treesitter, ui)
- Each plugin file returns a table of plugin specs for Lazy.nvim
- Plugin-specific keymaps are defined inside the plugin's `config` or `keys` field, not in the global keymaps file
- Global and cross-plugin keymaps live in `lua/config/keymaps.lua`

## LSP Configuration

- All LSP servers are configured through a single `server_configs` table in `lsp.lua`
- Uses Neovim 0.11+ native `vim.lsp.config[name]` and `vim.lsp.enable()` instead of lspconfig's `setup()` loop
- Mason ensures tools are installed; mason-lspconfig bridges Mason names to lspconfig names
- Mason npm package installs pass `--min-release-age=0` so registry-pinned server versions are not blocked by the user's global npm release-age guard
- ESLint is explicitly excluded from document formatting capability

## Formatting

- Conform handles all formatting with format-on-save (BufWritePre autocmd)
- Custom formatters defined inline: zigfmt, php_cs_fixer, terragrunt_fmt, ansible_lint
- Infrastructure YAML subtypes (yaml.ansible, yaml.gitlab, etc.) have dedicated formatter assignments

## Filetype Detection

- Extensive custom filetype rules in `autocmds.lua` for infrastructure files
- Terraform/HCL extensions map to `terraform` filetype
- YAML files are subtyped by filename and path patterns (e.g., `yaml.gitlab`, `yaml.kubernetes`, `yaml.helm`)
- Custom filetype `templ` and `yar` registered via `vim.filetype.add`
- Yar Tree-sitter queries and ftplugin files come from `/Users/yaroslavk/git/yar-treesitter` on runtimepath
- Yar parser loading prefers `stdpath('data')/site/parser/yar.so` and falls back to the local grammar checkout's `parser.so`

## Completion

- Source priority: Supermaven > LSP > LuaSnip > Buffer > Path
- Ghost text enabled for inline preview
- Completion auto-disabled for markdown filetypes
- CMP highlights are manually set to match Fleet theme palette

## Debugging and Testing

- DAP UI auto-opens on debug session start and auto-closes on termination
- Debug keymaps are conditionally registered only when DAP is available
- Python debugpy expects virtualenv at `~/.virtualenvs/debugpy/`
- Neotest uses pytest runner for Python tests

## Editor Defaults

- 4-space indentation globally; 2-space override for Terraform/HCL and YAML
- Mouse disabled; system clipboard enabled (unnamedplus)
- Persistent undo stored in stdpath cache
- Global statusline (laststatus=3)
- Wrap disabled; indent-preserving linebreak enabled

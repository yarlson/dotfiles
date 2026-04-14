# Summary

## What

A Neovim configuration optimized for DevOps, infrastructure, and backend development. Manages plugins via Lazy.nvim with modular per-concern configuration files.

## Architecture

- `init.lua` bootstraps Lazy.nvim, loads core config, disables netrw, then calls `lazy.setup('plugins')`
- `lua/config/` holds three core modules: options, keymaps, autocmds
- `lua/plugins/` holds nine plugin modules, each responsible for one functional area
- LSP uses Neovim 0.11+ native API (`vim.lsp.config` / `vim.lsp.enable`) with Mason for tool installation

## Core Flow

1. `init.lua` bootstraps Lazy.nvim from GitHub if missing, prepends it to runtimepath
2. Core config loads: editor options, keymaps, autocommands + filetype detection
3. `lazy.setup('plugins')` auto-discovers and lazy-loads all `lua/plugins/*.lua` modules
4. On buffer open: LSP attaches, Treesitter highlights, Gitsigns activates
5. On save: Conform formats the buffer (1s timeout, LSP fallback)
6. Neo-tree file explorer opens automatically on VimEnter

## System State

- Leader key: Space
- Theme: Fleet (fleet-theme-nvim)
- AI completion: Supermaven integrated into nvim-cmp (disabled for markdown)
- Format-on-save active for all supported filetypes
- Neo-tree auto-opens on startup (left panel, 30px wide)
- Completion toggle commands: `:Cmpoff`, `:Cmpon`, `:CmpoffAll`, `:CmponAll`

## Capabilities

- **Infrastructure**: Terraform/Terragrunt LSP + formatting, Ansible LSP + linting, Docker LSP + hadolint, Kubernetes/Helm YAML schemas, shell scripting (shellcheck, shfmt)
- **Languages**: Go, Python, Zig, Lua, JS/TS, PHP, SQL, Bash
- **Debugging**: DAP with UI for Go (Delve), Python (debugpy), Zig (LLDB)
- **Testing**: Neotest for Go and Python with DAP integration
- **Git**: Gitsigns (hunk ops), Neogit (magit-like UI), git-conflict (merge resolution)
- **Navigation**: Telescope (fuzzy finder + project picker), Harpoon (file marks), Neo-tree (explorer)
- **AI**: Claude Code terminal integration, Supermaven inline completion

## Tech Stack

- Neovim 0.11+ (required for native LSP config API)
- Lazy.nvim plugin manager
- Mason + mason-lspconfig for LSP/tool installation
- Conform.nvim for formatting
- nvim-cmp + LuaSnip for completion
- Treesitter for syntax and text objects
- Lua (LuaJIT runtime)

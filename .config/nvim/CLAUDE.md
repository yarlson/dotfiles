# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration focused on DevOps and infrastructure development. The configuration uses Lazy.nvim as the plugin manager and is structured with a modular approach for maximum maintainability.

## Development Commands

### Neovim Configuration Management
- `./clenup.sh` - Clean Neovim cache and data directories for fresh start
- No build/test commands - configuration is loaded directly by Neovim

### Configuration Testing
- Test configuration by running `nvim` and checking for errors
- Plugin sync: `:Lazy sync` to update/install plugins
- Health check: `:checkhealth` to verify configuration

### Claude Code Commands
- `:ClaudeCode` - Toggle Claude Code terminal window
- `:ClaudeCodeContinue` - Resume most recent conversation
- `:ClaudeCodeResume` - Interactive conversation picker
- `:ClaudeCodeVerbose` - Enable verbose logging

## Architecture

### Core Structure
The configuration follows a clean separation of concerns:

- `init.lua` - Bootstrap Lazy.nvim and load core configurations
- `lua/config/` - Core Neovim settings, keymaps, and autocommands
- `lua/plugins/` - Plugin configurations organized by functionality

### Plugin Architecture
Plugin configurations are modular and organized by purpose:

- `completion.lua` - nvim-cmp with Supermaven AI completion
- `debug.lua` - DAP debugging for Go, Python, Zig
- `editor.lua` - Core editing plugins (Neo-tree, Harpoon, Trouble)
- `formatting.lua` - Conform.nvim with language-specific formatters
- `git.lua` - Git integration (Gitsigns, Neogit, conflict resolution)
- `lsp.lua` - Language server configurations via Mason
- `telescope.lua` - Fuzzy finder with specialized pickers
- `treesitter.lua` - Syntax highlighting and text objects
- `ui.lua` - Interface plugins (Bufferline, Lualine, theme)

### Language Support Focus
The configuration is optimized for:

**Infrastructure/DevOps:**
- Terraform/Terragrunt with specialized formatting and LSP
- Ansible with YAML schema support
- Docker with linting (hadolint)
- Kubernetes YAML with schema validation
- Helm charts with syntax support
- Shell scripting with shellcheck and shfmt

**Programming Languages:**
- Go with debugging (delve) and testing
- Python with debugging (debugpy) and testing
- Zig with LSP and debugging (LLDB)
- Lua with Neovim-specific enhancements
- JavaScript/TypeScript with ESLint and Prettier

### Key Architectural Decisions

1. **Leader Key**: Space (`<Space>`) for consistency and accessibility
2. **Plugin Manager**: Lazy.nvim for performance and lazy loading
3. **LSP Management**: Mason for automatic tool installation
4. **Formatting**: Conform.nvim with format-on-save for all file types
5. **File Tree**: Neo-tree opens automatically on startup
6. **Git Integration**: Multiple tools for comprehensive git workflow
7. **Debugging**: Full DAP setup for supported languages
8. **Testing**: Neotest integration for Go and Python

### File Type Detection
Extensive custom file type detection for infrastructure files:
- `.tf`, `.hcl`, `.tfvars` → Terraform
- `terragrunt.hcl` → Terragrunt  
- `Jenkinsfile` → Groovy
- Various YAML patterns → Specific YAML schemas (GitLab CI, GitHub Actions, Kubernetes, Helm, etc.)

### Autocommands
- **Format on Save**: Automatic formatting for all supported file types
- **Neo-tree Auto-open**: File explorer opens on startup
- **Language-specific Settings**: Automatic indentation and comment settings per file type

## Key Features

### Completion System
- AI-powered completion via Supermaven
- LSP-based completion for all supported languages
- Snippet support with LuaSnip
- Automatic completion disabled for markdown files

### Debugging Setup
Full debugging support with visual interface:
- Go: Delve debugger integration
- Python: debugpy with virtual environment support  
- Zig: LLDB integration

### Testing Integration
- Neotest framework for running tests
- Go and Python test adapters
- Test output and summary windows

### REST Client
Built-in HTTP client for API testing and development.

### Claude Code Integration
Direct integration with Claude Code AI assistant:
- Toggle Claude Code terminal with `<leader>cc`
- Continue previous conversations with `<leader>cC`
- Verbose mode with `<leader>cV`
- Automatic file reload when Claude Code modifies files
- Uses git root as working directory when available

### Git Workflow
Complete git integration:
- Visual git status and diff indicators
- Hunk-level staging and operations
- Conflict resolution helpers
- Full git interface via Neogit

The configuration emphasizes productivity for infrastructure and backend development while maintaining clean, readable code organization.
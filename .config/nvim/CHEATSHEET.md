# Neovim Configuration Cheatsheet

## Core Settings
- **Leader Key**: `<Space>`
- **Local Leader**: `<Space>`
- **Mouse**: Disabled
- **Clipboard**: System clipboard integration enabled
- **Line Numbers**: Relative numbers enabled

## Buffer Navigation

### Standard Buffer Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `<C-l>` | Next Buffer | Standard Neovim buffer navigation |
| `<C-h>` | Previous Buffer | Standard Neovim buffer navigation |

### Bufferline Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `[b` | Previous Buffer | Bufferline specific navigation |
| `]b` | Next Buffer | Bufferline specific navigation |
| `<leader>1-9` | Go to Buffer N | Jump directly to buffer by number |
| `<leader>bd` | Delete Buffer | Close current buffer (using Bdelete) |

## File Explorer (Neo-tree)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle Neo-tree | Toggle file explorer |
| `<C-w>e` | Focus Neo-tree | Focus file explorer or return to previous window |

**Neo-tree Features:**
- Opens automatically on startup
- Shows git status and diagnostics
- 30-character width, left-side position
- Follows current file

## Telescope (Fuzzy Finder)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ff` | Find Files | Search for files in project |
| `<leader>fg` | Live Grep | Search text across files |
| `<leader>fb` | List Buffers | Show open buffers |
| `<leader>fh` | Help Tags | Search help documentation |
| `<leader>fp` | Find Projects | Browse projects |
| `<leader>dt` | Terraform Docs | Terraform documentation search |
| `<leader>dy` | YAML Schema | YAML schema selector |

**Telescope Buffer Actions:**
- `<C-d>` in buffer picker: Delete selected buffer

## LSP (Language Server Protocol)
| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to Definition | Jump to symbol definition |
| `gr` | Find References | Show all references |
| `gi` | Go to Implementation | Jump to implementation |
| `K` | Hover Documentation | Show documentation popup |
| `<leader>rn` | Rename Symbol | Rename symbol across project |
| `<leader>ca` | Code Action | Show available code actions |
| `<leader>f` | Format Document | Format current file |

### Diagnostics (Trouble)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>xx` | Toggle Trouble | Show/hide diagnostics panel |
| `<leader>xw` | Workspace Diagnostics | Show workspace-wide issues |
| `<leader>xd` | Document Diagnostics | Show current file issues |
| `<leader>xl` | Location List | Show location list |
| `<leader>xq` | Quickfix List | Show quickfix list |
| `gR` | LSP References | Show references in Trouble |

## Git Integration

### Gitsigns
| Key | Action | Description |
|-----|--------|-------------|
| `]h` | Next Hunk | Jump to next git change |
| `[h` | Previous Hunk | Jump to previous git change |
| `<leader>gs` | Stage Hunk | Stage current hunk |
| `<leader>gr` | Reset Hunk | Reset current hunk |
| `<leader>gS` | Stage Buffer | Stage entire file |
| `<leader>gu` | Undo Stage Hunk | Undo hunk staging |
| `<leader>gR` | Reset Buffer | Reset entire file |
| `<leader>gp` | Preview Hunk | Preview hunk changes |
| `<leader>gb` | Blame Line | Show git blame for line |
| `<leader>gd` | Diff This | Show diff for current file |
| `<leader>gD` | Diff Against HEAD | Show diff against HEAD |
| `<leader>gt` | Toggle Deleted | Show/hide deleted lines |
| `ih` | Select Hunk | Text object for git hunk |

### Neogit
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gg` | Open Neogit | Open git interface |
| `<leader>gc` | Neogit Commit | Open commit interface |

### Git Conflicts
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>co` | Choose Ours | Accept our changes |
| `<leader>ct` | Choose Theirs | Accept their changes |
| `<leader>cb` | Choose Both | Accept both changes |
| `<leader>c0` | Choose None | Reject both changes |
| `]x` | Next Conflict | Jump to next conflict |
| `[x` | Previous Conflict | Jump to previous conflict |

## Debugging (DAP)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Toggle Breakpoint | Set/remove breakpoint |
| `<leader>dc` | Continue | Continue execution |
| `<leader>ds` | Step Over | Step over current line |
| `<leader>di` | Step Into | Step into function |
| `<leader>do` | Step Out | Step out of function |
| `<leader>du` | Toggle DAP UI | Show/hide debug interface |

**Supported Languages:**
- Go (using Delve)
- Python (using debugpy)
- Zig (using LLDB)

## Testing (Neotest)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>tf` | Run File Tests | Run all tests in current file |
| `<leader>tn` | Run Nearest Test | Run test under cursor |
| `<leader>ts` | Toggle Test Summary | Show/hide test summary |
| `<leader>to` | Show Test Output | Display test results |
| `<leader>td` | Debug Nearest Test | Debug test under cursor |

## REST Client
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>rr` | Run REST Request | Execute HTTP request under cursor |
| `<leader>rp` | Preview Request | Preview HTTP request |
| `<leader>rl` | Re-run Last Request | Execute last HTTP request |

## Harpoon (Quick File Access)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ha` | Mark File | Add current file to harpoon |
| `<leader>hh` | Harpoon Menu | Show harpoon quick menu |
| `<leader>h1-4` | Go to File N | Jump to harpoon file 1-4 |

## Terminal
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>t` | Toggle Terminal | Open/close terminal |

## Claude Code Integration
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>cc` | Toggle Claude Code | Open/close Claude Code terminal |
| `<leader>cC` | Continue Conversation | Resume most recent Claude Code conversation |
| `<leader>cV` | Verbose Mode | Open Claude Code with verbose logging |
| `<C-,>` | Toggle (Terminal) | Toggle Claude Code from terminal mode |

**Claude Code Features:**
- Automatically uses git root as working directory
- Real-time file reload when Claude modifies files
- Window navigation with `<C-h/j/k/l>` in terminal
- Page scrolling with `<C-f/b>` in terminal

## Text Objects (Treesitter)
| Key | Action | Description |
|-----|--------|-------------|
| `af`/`if` | Function | Select around/inside function |
| `ac`/`ic` | Class | Select around/inside class |
| `aB`/`iB` | Block | Select around/inside block |
| `aP`/`iP` | Parameter | Select around/inside parameter |

### Movement
| Key | Action | Description |
|-----|--------|-------------|
| `]f`/`[f` | Next/Previous Function | Jump to function start |
| `]F`/`[F` | Next/Previous Function End | Jump to function end |
| `]]`/`[[` | Next/Previous Class | Jump to class start |
| `][`/`[]` | Next/Previous Class End | Jump to class end |

### Swapping
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>a` | Swap Next Parameter | Swap with next parameter |
| `<leader>A` | Swap Previous Parameter | Swap with previous parameter |

## Completion (nvim-cmp + Supermaven)
| Key | Action | Description |
|-----|--------|-------------|
| `<Tab>` | Next Item | Select next completion item |
| `<S-Tab>` | Previous Item | Select previous completion item |
| `<CR>` | Confirm | Accept selected completion |
| `<C-Space>` | Trigger Completion | Manually trigger completion |
| `<C-b>`/`<C-f>` | Scroll Docs | Scroll completion documentation |
| `<Esc>` | Abort | Close completion menu |

### Completion Commands
| Command | Description |
|---------|-------------|
| `:Cmpoff` | Disable completion for current buffer |
| `:Cmpon` | Enable completion for current buffer |
| `:CmpoffAll` | Disable completion globally |
| `:CmponAll` | Enable completion globally |

**Note:** Completion is automatically disabled for markdown files.

## Supported Languages & Tools

### Programming Languages
- **Go**: LSP (gopls), debugging (delve), testing, formatting
- **Python**: LSP (pyright), debugging (debugpy), testing, formatting (black)
- **JavaScript/TypeScript**: LSP (ts_ls), formatting (prettier)
- **Lua**: LSP (lua_ls), formatting (stylua), Neovim-specific setup
- **Zig**: LSP (zls), debugging (lldb), formatting (zigfmt)
- **PHP**: LSP (intelephense), formatting (php-cs-fixer)
- **SQL**: LSP (sqlls), formatting (sql-formatter)

### DevOps & Infrastructure
- **Terraform**: LSP (terraformls), formatting, documentation
- **Terragrunt**: Custom formatting, file type detection
- **Ansible**: LSP (ansiblels), linting, YAML schema support
- **Docker**: LSP (dockerls), Dockerfile linting (hadolint)
- **Kubernetes**: YAML schemas, syntax highlighting
- **Helm**: LSP (helm_ls), syntax highlighting
- **YAML**: LSP (yamlls), multiple schema support, formatting
- **Bash/Shell**: LSP (bashls), linting (shellcheck), formatting (shfmt)

### File Type Detection
The configuration automatically detects and applies appropriate settings for:
- `.tf`, `.hcl`, `.tfvars` → Terraform
- `terragrunt.hcl` → Terragrunt
- `Jenkinsfile` → Groovy
- `.gitlab-ci.yml` → GitLab CI
- `docker-compose.yml` → Docker Compose
- `Chart.yaml`, `values.yaml` → Helm
- Kubernetes manifests
- GitHub Actions workflows

## Formatting (Conform)
Automatic formatting on save is enabled for all supported file types.

### Manual Formatting
- `<leader>f` - Format current file via LSP
- Conform handles format-on-save automatically

## Color Scheme
- **Theme**: Flexoki Dark
- **Features**: True color support, consistent highlighting

## Which-Key
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>?` | Show Local Keymaps | Display buffer-specific keybindings |

## Comments
- Uses Comment.nvim for intelligent commenting
- Supports all configured file types with appropriate comment strings

## Auto Commands
- **Format on Save**: Automatically formats files using Conform
- **Neo-tree Auto-open**: Opens file explorer on startup
- **File Type Settings**: Applies language-specific indentation and settings
- **Completion Control**: Disables completion for markdown files

## Tips
1. **Project Detection**: Automatically detects projects based on `.git`, `Makefile`, `package.json`, etc.
2. **Schema Validation**: YAML files get automatic schema validation for common tools
3. **Git Integration**: Full git workflow support with visual indicators
4. **Debug Support**: Comprehensive debugging setup for multiple languages
5. **REST Testing**: Built-in HTTP client for API testing
6. **Infra Focus**: Extensive DevOps and infrastructure tooling support 
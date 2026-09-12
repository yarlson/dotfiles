# Neovim Configuration Cheatsheet

Keys use Normal mode unless noted. `<leader>` means `<Space>`; for example, `<leader>ff` means Space, then f, then f.

This sheet describes the Lua configuration and plugin versions in `lazy-lock.json`. Plugins and external tools must be installed for their features to work.

## Core Settings

- **Leader Key**: `<Space>`
- **Local Leader**: `<Space>`
- **Mouse**: Disabled
- **Clipboard**: System clipboard integration enabled
- **Line Numbers**: Relative numbers enabled

## Buffer Navigation

### Standard Buffer Navigation

| Key     | Action          | Description      |
| ------- | --------------- | ---------------- |
| `<C-l>` | Next Buffer     | Run `:bnext`     |
| `<C-h>` | Previous Buffer | Run `:bprevious` |

### Bufferline Navigation

| Key                     | Action          | Description                                 |
| ----------------------- | --------------- | ------------------------------------------- |
| `[b`                    | Previous Buffer | Bufferline specific navigation              |
| `]b`                    | Next Buffer     | Bufferline specific navigation              |
| `<leader>1`–`<leader>9` | Go to Buffer N  | Jump to the buffer's position in Bufferline |
| `<leader>bd`            | Delete Buffer   | Close current buffer (using Bdelete)        |

## File Explorer (Neo-tree)

| Key         | Action          | Description                                      |
| ----------- | --------------- | ------------------------------------------------ |
| `<leader>e` | Toggle Neo-tree | Toggle file explorer                             |
| `<C-w>e`    | Focus Neo-tree  | Focus file explorer or return to previous window |

**Neo-tree Features:**

- Opens on startup unless you open exactly one file; opens with no arguments, a directory, or multiple files
- Shows git status and diagnostics
- 30-character width, left-side position
- Follows current file

## Telescope (Fuzzy Finder)

| Key          | Action         | Description                    |
| ------------ | -------------- | ------------------------------ |
| `<leader>ff` | Find Files     | Search for files in project    |
| `<leader>fg` | Live Grep      | Search text across files       |
| `<leader>fb` | List Buffers   | Show open buffers              |
| `<leader>fh` | Help Tags      | Search help documentation      |
| `<leader>fp` | Find Projects  | Browse projects                |
| `<leader>dt` | Terraform Docs | Terraform documentation search |
| `<leader>dy` | YAML Schema    | YAML schema selector           |

**Telescope Buffer Actions:**

- `<C-d>` in the buffer picker's Insert mode: force-delete the selected buffer, discard unsaved changes, and close the picker

## LSP (Language Server Protocol)

These keys are set for a buffer when a language server attaches. Each action requires server support.

| Key          | Action               | Description                   |
| ------------ | -------------------- | ----------------------------- |
| `gd`         | Go to Definition     | Jump to symbol definition     |
| `gr`         | Find References      | Show all references           |
| `gi`         | Go to Implementation | Jump to implementation        |
| `K`          | Hover Documentation  | Show documentation popup      |
| `<leader>rn` | Rename Symbol        | Rename symbol across project  |
| `<leader>ca` | Code Action          | Show available code actions   |
| `<leader>f`  | Format Document      | Format asynchronously via LSP |

### Diagnostics (Trouble)

Some mappings use an older Trouble API. With the locked version, their behavior is:

| Key          | Current behavior                                                                  |
| ------------ | --------------------------------------------------------------------------------- |
| `<leader>xx` | Close an open Trouble view; reports “No mode specified” when no view is available |
| `<leader>xw` | Invalid mode: `workspace_diagnostics`                                             |
| `<leader>xd` | Invalid mode: `document_diagnostics`                                              |
| `<leader>xl` | Toggle the location list                                                          |
| `<leader>xq` | Toggle the quickfix list                                                          |
| `gR`         | Calls the unavailable `lsp_references()` function                                 |

Use these commands for diagnostics and references:

- `:Trouble diagnostics toggle` — all diagnostics
- `:Trouble diagnostics toggle filter.buf=0` — current buffer diagnostics
- `:Trouble lsp_references toggle` — references to the symbol under the cursor

See the locked version's [API](https://github.com/folke/trouble.nvim/blob/bd67efe408d4816e25e8491cc5ad4088e708a69a/lua/trouble/api.lua) and [commands](https://github.com/folke/trouble.nvim/blob/bd67efe408d4816e25e8491cc5ad4088e708a69a/README.md#usage).

## Git Integration

### Gitsigns

These keys are available in buffers where Gitsigns attaches. `ih` works in Visual and Operator-pending modes.

| Key          | Action                       | Description                           |
| ------------ | ---------------------------- | ------------------------------------- |
| `]h`         | Next Hunk                    | Jump to next git change               |
| `[h`         | Previous Hunk                | Jump to previous git change           |
| `<leader>gs` | Stage Hunk                   | Stage current hunk                    |
| `<leader>gr` | Reset Hunk                   | Reset current hunk                    |
| `<leader>gS` | Stage Buffer                 | Stage entire file                     |
| `<leader>gu` | Undo Stage Hunk              | Undo hunk staging                     |
| `<leader>gR` | Reset Buffer                 | Reset entire file                     |
| `<leader>gp` | Preview Hunk                 | Preview hunk changes                  |
| `<leader>gb` | Blame Line                   | Show git blame for line               |
| `<leader>gd` | Diff Against Index           | Compare the buffer with the Git index |
| `<leader>gD` | Diff Against Previous Commit | Compare with `HEAD~1` (`~`)           |
| `<leader>gt` | Toggle Deleted               | Show/hide deleted lines               |
| `ih`         | Select Hunk                  | Text object for git hunk              |

### Neogit

| Key          | Action        | Description           |
| ------------ | ------------- | --------------------- |
| `<leader>gg` | Open Neogit   | Open git interface    |
| `<leader>gc` | Neogit Commit | Open commit interface |

### Git Conflicts

| Key          | Action            | Description               |
| ------------ | ----------------- | ------------------------- |
| `<leader>co` | Choose Ours       | Accept our changes        |
| `<leader>ct` | Choose Theirs     | Accept their changes      |
| `<leader>cb` | Choose Both       | Accept both changes       |
| `<leader>c0` | Choose None       | Reject both changes       |
| `]x`         | Next Conflict     | Jump to next conflict     |
| `[x`         | Previous Conflict | Jump to previous conflict |

## Debugging (DAP)

These buffer-local keys are set when an LSP server attaches and DAP is available.

| Key          | Action            | Description               |
| ------------ | ----------------- | ------------------------- |
| `<leader>db` | Toggle Breakpoint | Set/remove breakpoint     |
| `<leader>dc` | Continue          | Continue execution        |
| `<leader>ds` | Step Over         | Step over current line    |
| `<leader>di` | Step Into         | Step into function        |
| `<leader>do` | Step Out          | Step out of function      |
| `<leader>du` | Toggle DAP UI     | Show/hide debug interface |

**Configured adapters:**

- Go: Delve (`dlv`)
- Python: debugpy; `nvim-dap-python` is configured to use `~/.virtualenvs/debugpy/bin/python`
- Zig: LLDB at `/usr/bin/lldb-vscode`; prompts for the executable to launch

The DAP UI opens when a session starts and closes when it terminates or exits.

## Testing (Neotest)

Adapters are configured for Go and Python. Python tests use `pytest`.

| Key          | Action              | Description                   |
| ------------ | ------------------- | ----------------------------- |
| `<leader>tf` | Run File Tests      | Run all tests in current file |
| `<leader>tn` | Run Nearest Test    | Run test under cursor         |
| `<leader>ts` | Toggle Test Summary | Show/hide test summary        |
| `<leader>to` | Show Test Output    | Display test results          |
| `<leader>td` | Debug Nearest Test  | Debug test under cursor       |

## REST Client (Inactive)

The mappings below exist in `lua/config/keymaps.lua`, but no REST client plugin is configured to provide their `<Plug>` targets. They do not currently run requests.

| Key          | Action              | Description                       |
| ------------ | ------------------- | --------------------------------- |
| `<leader>rr` | Run REST Request    | Execute HTTP request under cursor |
| `<leader>rp` | Preview Request     | Preview HTTP request              |
| `<leader>rl` | Re-run Last Request | Execute last HTTP request         |

## Harpoon (Quick File Access)

| Key                       | Action       | Description                 |
| ------------------------- | ------------ | --------------------------- |
| `<leader>ha`              | Mark File    | Add current file to harpoon |
| `<leader>hh`              | Harpoon Menu | Show harpoon quick menu     |
| `<leader>h1`–`<leader>h4` | Go to File N | Jump to Harpoon file 1–4    |

## Terminal

| Key         | Action          | Description                              |
| ----------- | --------------- | ---------------------------------------- |
| `<leader>t` | Toggle Terminal | Open/close a 15-line horizontal terminal |

## Claude Code Integration

| Key          | Action                | Description                                 |
| ------------ | --------------------- | ------------------------------------------- |
| `<leader>cc` | Toggle Claude Code    | Open/close Claude Code terminal             |
| `<leader>cC` | Continue Conversation | Resume most recent Claude Code conversation |
| `<leader>cV` | Verbose Mode          | Open Claude Code with verbose logging       |
| `<C-,>`      | Toggle (Terminal)     | Toggle Claude Code from terminal mode       |

**Claude Code Features:**

- Automatically uses git root as working directory
- Automatically reloads files changed by Claude
- Window navigation with `<C-h>`, `<C-j>`, `<C-k>`, and `<C-l>` in the Claude terminal
- Page scrolling with `<C-f>` and `<C-b>` in the Claude terminal; press `i` to resume typing afterward

## Text Objects (Treesitter)

Selections work in Visual and Operator-pending modes. Movement also works in Normal mode. Each feature needs an installed parser and matching text-object queries for the language.

| Key       | Action    | Description                    |
| --------- | --------- | ------------------------------ |
| `af`/`if` | Function  | Select around/inside function  |
| `ac`/`ic` | Class     | Select around/inside class     |
| `aB`/`iB` | Block     | Select around/inside block     |
| `aP`/`iP` | Parameter | Select around/inside parameter |

### Movement

| Key       | Action                     | Description            |
| --------- | -------------------------- | ---------------------- |
| `]f`/`[f` | Next/Previous Function     | Jump to function start |
| `]F`/`[F` | Next/Previous Function End | Jump to function end   |
| `]]`/`[[` | Next/Previous Class        | Jump to class start    |
| `][`/`[]` | Next/Previous Class End    | Jump to class end      |

### Swapping

| Key         | Action                  | Description                  |
| ----------- | ----------------------- | ---------------------------- |
| `<leader>a` | Swap Next Parameter     | Swap with next parameter     |
| `<leader>A` | Swap Previous Parameter | Swap with previous parameter |

## Completion (nvim-cmp + Supermaven)

The following nvim-cmp mappings apply in Insert mode:

| Key             | Action             | Description                                                     |
| --------------- | ------------------ | --------------------------------------------------------------- |
| `<Tab>`         | Next Item          | Select next completion item                                     |
| `<S-Tab>`       | Previous Item      | Select previous completion item                                 |
| `<CR>`          | Confirm            | Accept the selected item, or the first item if none is selected |
| `<C-Space>`     | Trigger Completion | Manually trigger completion                                     |
| `<C-b>`/`<C-f>` | Scroll Docs        | Scroll completion documentation                                 |
| `<Esc>`         | Abort              | Close completion menu                                           |

Supermaven also enables its default Insert-mode keys: `<Tab>` accepts an inline suggestion, `<C-j>` accepts its next word, and `<C-]>` clears it. Both plugins assign `<Tab>`, so it is not a dedicated “next completion item” key. See the locked [Supermaven defaults](https://github.com/supermaven-inc/supermaven-nvim/blob/07d20fce48a5629686aefb0a7cd4b25e33947d50/lua/supermaven-nvim/config.lua).

### Completion Commands

| Command      | Description                                   |
| ------------ | --------------------------------------------- |
| `:Cmpoff`    | Disable nvim-cmp for the current buffer       |
| `:Cmpon`     | Enable nvim-cmp for the current buffer        |
| `:CmpoffAll` | Disable nvim-cmp globally and stop Supermaven |
| `:CmponAll`  | Enable nvim-cmp globally and start Supermaven |

Markdown buffers automatically disable nvim-cmp. This does not disable Supermaven. Buffer-local nvim-cmp settings can override the global setting; use `:Cmpon` to re-enable nvim-cmp in a Markdown buffer.

## Configured Languages & Tools

### Programming Languages

- **Go**: LSP (gopls), debugging (delve), testing, formatting
- **Python**: LSP (pyright), debugging (debugpy), testing, formatting (black)
- **JavaScript/TypeScript**: LSP (ts_ls), formatting (prettier)
- **Lua**: LSP (lua_ls), formatting (stylua), Neovim-specific setup
- **Zig**: LSP (zls), debugging (lldb), formatting (zigfmt)
- **PHP**: LSP (intelephense), formatting (php-cs-fixer)
- **SQL**: LSP (sqlls), formatting (sql-formatter)
- **JSON**: LSP (jsonls), formatting (prettier)
- **HTML/CSS**: Formatting (prettier), Tailwind CSS LSP (tailwindcss)
- **Templ**: LSP (templ), filetype detection, Tree-sitter grammar dependency
- **Yar**: `.yar` filetype detection; optional Tree-sitter support from the configured local grammar checkout at `/Users/yaroslavk/git/yar-treesitter`

### DevOps & Infrastructure

- **Terraform**: LSP (terraformls), formatting, documentation
- **Terragrunt**: Custom formatting, file type detection
- **Ansible**: LSP (ansiblels), linting, YAML schema support
- **Docker**: LSP (dockerls); Conform lists prettier and dockerfile_lint
- **Kubernetes**: Filetype rules and a schema entry in the YAML schema picker
- **Helm**: LSP (helm_ls), syntax highlighting
- **YAML**: LSP (yamlls), multiple schema support, formatting
- **Bash/Shell**: LSP (bashls), formatting (shfmt)

`hadolint`, `shellcheck`, and other tools appear in Mason's options, but that list alone does not establish an active linting integration. Formatters and debuggers also need their executables available.

### File Type Detection

Custom filetype rules include:

- `.tf`, `.hcl`, `.tfvars` → Terraform
- `terragrunt.hcl` → Terragrunt
- `.tfstate` → JSON
- `Jenkinsfile` → Groovy
- `.gitlab-ci.yml` and paths ending in `.gitlab-ci.yml` or `.gitlab-ci.yaml` → `yaml.gitlab`
- `docker-compose.yml`, `docker-compose.yaml` → `yaml.docker-compose`
- `Chart.yaml`, `values.yaml` → `yaml.helm`
- `kustomization.yaml`, `kustomization.yml`, and paths ending in `.k8s.yml`, `.k8s.yaml`, `.kubernetes.yml`, or `.kubernetes.yaml` → `yaml.kubernetes`
- YAML paths under `.github/workflows/` → `yaml.github`
- YAML paths containing `playbook` or ending in `site.yml` or `site.yaml` → `yaml.ansible`
- `.templ` → `templ`; `.yar` → `yar`

Filetype detection and YAML schema matching use separate rules. These filename rules do not detect arbitrary Kubernetes manifests from their contents.

## Formatting (Conform)

Conform runs before saving, using the configured formatters available for the buffer. Its save options set a 1-second timeout and allow LSP fallback when no formatter is available. A second `BufWritePre` hook in `lua/config/autocmds.lua` also calls Conform, so a save can invoke formatting twice.

### Manual Formatting

- `<leader>f` — format asynchronously through an attached LSP server
- `:lua require('conform').format()` — run the configured Conform formatters manually
- `:ConformInfo` — inspect formatter availability and errors

## Color Scheme

- **Theme**: Fleet (`fleet-theme-nvim`)
- **Features**: True color support, consistent highlighting

## Which-Key

| Key         | Action             | Description                         |
| ----------- | ------------------ | ----------------------------------- |
| `<leader>?` | Show Local Keymaps | Display buffer-specific keybindings |

## Comments

- Comment.nvim uses its default mappings and the buffer's comment string.
- Terraform/HCL uses `# %s`; Groovy uses `// %s`.

## Auto Commands

- **Format on Save**: Automatically formats files using Conform
- **Neo-tree Auto-open**: Opens on startup unless exactly one file was opened
- **File Type Settings**: Applies language-specific indentation and settings
- **Completion Control**: Disables nvim-cmp for Markdown buffers; Supermaven remains enabled

## Tips

1. **Project Detection**: Uses markers such as `.git`, `Makefile`, and `package.json`, then LSP information.
2. **YAML Schemas**: Explicit schema patterns cover Docker Compose, GitLab CI, GitHub Actions, Ansible playbooks, Kustomization, and `Chart.yaml`; the YAML language server must attach for validation.

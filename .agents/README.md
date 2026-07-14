# Agent Configuration

Shared instructions and prompts for coding agents.

## Structure

- `AGENTS.md` — generated global agent instructions.
- `prompts/` — source policies and the installer script.

## Update global instructions

Edit the policy files in `prompts/`, then run:

```bash
~/.agents/prompts/install_prompts.sh
```

The script combines the policies and installs identical instructions at
`~/.claude/CLAUDE.md`, `~/.agents/AGENTS.md`, and `~/.codex/AGENTS.md`.
Edit the source policies instead of these generated files.

## System Prompt — Memory Vault

You manage persistent project knowledge in the **Memory Vault**, stored in the `memory/` directory. The Memory Vault is the project’s long-term memory and must always reflect the current system state.

### Core Rules

- Store anything needed for future sessions in the Memory Vault.
- Summarize vault contents in chat unless a specific file is requested.
- If vault content conflicts with the codebase, treat code as truth and update the vault.
- The vault documents current state, not change history.
- Temporary notes and session scraps go in `memory/tmp/`.

### Implementation Learnings

During implementation phases, capture durable learnings—especially what went wrong and how to prevent it in the future—when a root cause is identified and a stable prevention rule or correct pattern exists (technical or product/UX). Keep raw incident notes in `memory/tmp/`; record only durable, consolidated guidance in the Vault.

Detailed rules for recording, promoting, structuring, and consolidating learnings are defined in:

```
~/.claude/learnings.md
```

### Memory Vault Structure

Create missing parts as needed.

```
memory/
  summary.md          # current project snapshot
  terminology.md      # term — meaning lines
  practices.md        # conventions and invariants
  memory-map.md       # index of all vault files
  plans/              # roadmaps and TODOs
  tmp/                # git-ignored session notes & handovers
  [domain]/           # e.g. auth/, ui/, parser/
    summary.md
    *.md              # one topic per file
```

### File Standards

Each file should:

- cover one topic only
- include examples and Mermaid diagrams when useful
- link related files via relative paths
- stay under ~250 lines; split if larger

### Workflow

- At session start, read:
  - `memory/memory-map.md`
  - `memory/summary.md`
  - `memory/terminology.md`

- Before exploring code, consult `memory/memory-map.md`.

- When decisions are finalized, update or create the corresponding vault entries immediately.

- After major changes, reorganize the vault if it no longer mirrors the project.

### Handovers

On request, create `memory/tmp/handover-YYYY-MM-DD.md` containing session state, decisions, blockers, and next steps.

### Missing Vault

If `memory/` does not exist, ask whether it should be created.

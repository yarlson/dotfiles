## Learning Capture Policy

The Memory Vault must capture key implementation learnings, especially:

- what went wrong (problem)
- why it happened (root cause)
- how to prevent it (rule/invariant)
- the correct pattern (implementation guidance)
- how to detect it early (tests/alerts/checks)

This includes both technical and product/UX learnings.

### Two-tier flow (noise control)

Raw incidents and debugging notes go to:
memory/tmp/errors/

Only durable lessons live in:

- memory/<domain>/learnings.md
- memory/learnings.md for cross-domain lessons

### Promotion rule

Promote a learning when:

- root cause is understood
- a stable prevention rule or pattern exists

Do not wait for user confirmation.

### Consolidation rule

Learning files are living policies and must be periodically consolidated:

- merge duplicates
- remove obsolete entries
- maintain concise canonical guidance

Prefer rewriting guidance instead of accumulating entries.

### Learning entry format

Each entry should contain:

Problem  
Root cause  
Rule (must always hold)  
Implementation pattern  
Detection  
Refs (relative links)

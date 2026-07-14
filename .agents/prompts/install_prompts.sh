#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly HOME_DIR="${HOME:?HOME must be set}"
COMBINED_FILE="$(mktemp "${TMPDIR:-/tmp}/combined-agent-prompts.XXXXXX")"
readonly SCRIPT_DIR COMBINED_FILE

cleanup() {
  rm -f -- "$COMBINED_FILE"
}
trap cleanup EXIT

{
  cat "$SCRIPT_DIR/ENGINEERING_QUALITY_GATE.md"
  printf '\n'
  cat "$SCRIPT_DIR/EXISTING_CODEBASE_FIRST.md"
  printf '\n'
  cat "$SCRIPT_DIR/SMALL_DESIGN_BEFORE_CODE.md"
  printf '\n'
  cat "$SCRIPT_DIR/NEW_CODE_COMPLEXITY_BUDGET.md"
  printf '\n'
  cat "$SCRIPT_DIR/CODE_COMMENT_POLICY.md"
} > "$COMBINED_FILE"

destinations=(
  "$HOME_DIR/.claude/CLAUDE.md"
  "$HOME_DIR/.agents/AGENTS.md"
  "$HOME_DIR/.codex/AGENTS.md"
)

for destination in "${destinations[@]}"; do
  mkdir -p -- "$(dirname -- "$destination")"
  install -m 0644 "$COMBINED_FILE" "$destination"
done

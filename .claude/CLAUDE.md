# CLAUDE.md

## Coding rules

- Think before coding.
- State assumptions explicitly.
- If something is unclear, say so instead of guessing.
- Prefer the simplest solution that fully solves the task.
- Do not add extra features, abstractions, or configurability unless asked.
- Make surgical changes only.
- Do not refactor unrelated code.
- Match the existing style of the codebase.
- Clean up only unused code created by your own changes.
- Every changed line should map directly to the request.

## Execution rules

- Define clear success criteria before implementing.
- For bug fixes, reproduce the bug first when practical.
- Revalidate version-sensitive or unfamiliar framework, language, and library assumptions: check the installed version, local config/docs, and official docs or changelog; state the source when it affects the implementation.
- For changes, verify with tests or another concrete check.
- For multi-step work, make a short plan with a verification step for each part.

## Heuristic

Ask: would a senior engineer call this overcomplicated? If yes, simplify.

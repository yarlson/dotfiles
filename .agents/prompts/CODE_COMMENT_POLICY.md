## Code Comment Policy

Use comments only when they clarify the current code state.

Comments must describe what is true now: invariants, constraints, non-obvious behavior, edge cases, safety requirements, protocol rules, ownership rules, or reasons the code would be easy to misuse.

Do not write comments as:

- decision logs
- implementation history
- change summaries
- PR explanations
- prose narratives
- apologies
- TODOs without an owner or concrete condition
- explanations of obvious syntax
- restatements of function names
- speculation about future changes
- product or business commentary
- notes about what was removed or replaced
- “temporary” comments unless there is a clear removal condition

Prefer self-explanatory code over comments. Rename variables, split functions, or simplify control flow before adding a comment.

Good comments should answer one of these:

- What invariant must hold here?
- What external contract forces this behavior?
- What edge case is intentionally handled?
- What would break if this changed?
- Why is the obvious simpler approach unsafe here?
- What ownership, lifecycle, concurrency, or ordering rule matters?

Before finalizing, review all comments touched by the change:

1. Remove stale comments.
2. Remove comments that only describe old decisions.
3. Remove comments that duplicate the code.
4. Update comments so they match the current implementation exactly.
5. Add comments only where the code remains non-obvious after simplification.

Final rule: comments must document the present system, not the journey that produced it.

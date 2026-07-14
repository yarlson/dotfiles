## Engineering Quality Gate

In addition to solving the product/task goal, treat codebase quality as a first-class requirement.

Do not optimize only for visible product behavior. The implementation must also preserve or improve maintainability, correctness, simplicity, testability, and long-term engineering health.

### Hard constraints

Before implementing, during implementation, and before finalizing, validate the work against these gates:

1. **Smallest safe change surface**
   - Prefer localized changes.
   - Do not rewrite, reorganize, or refactor unrelated code.
   - Do not introduce broad abstractions unless they are clearly needed now.
   - Do not change public behavior, APIs, data models, config, or operational behavior unless required by the task.

2. **Correctness**
   - Handle normal, edge, and failure paths.
   - Preserve existing behavior unless explicitly changing it.
   - Avoid partial-state bugs, ordering bugs, race conditions, nil/null handling issues, off-by-one errors, stale reads, and unsafe assumptions.
   - Make invalid states hard or impossible to represent where practical.

3. **Maintainability**
   - Keep code readable, boring, and easy to modify.
   - Prefer clear names and straightforward control flow.
   - Avoid cleverness, hidden coupling, unnecessary indirection, and “magic.”
   - Keep responsibilities separated.
   - Do not mix unrelated concerns in the same function, class, module, or commit.

4. **Complexity budget**
   - Keep cyclomatic and cognitive complexity low.
   - Split functions that have too many branches, nested conditions, modes, or responsibilities.
   - Prefer simple guard clauses over deep nesting.
   - Avoid adding state machines, reconciliation loops, event-driven flows, background workers, queues, plugin systems, generic frameworks, or broad dependency injection unless the simpler approach is insufficient.
   - If a complex pattern is necessary, explicitly justify why.

5. **Codebase consistency**
   - Follow existing project conventions for structure, naming, errors, logging, testing, configuration, dependency injection, and API shape.
   - Reuse existing helpers and patterns where they are healthy.
   - Do not introduce a second way to solve the same problem without a strong reason.

6. **Testing**
   - Add or update tests for the changed behavior.
   - Cover important edge cases and failure paths.
   - Prefer deterministic tests over sleeps, timing assumptions, external services, or brittle snapshots.
   - Do not weaken, delete, or skip existing tests unless clearly justified.
   - If a change is hard to test, explain why and add the best practical verification.

7. **Error handling and observability**
   - Do not swallow errors.
   - Return, wrap, log, or surface errors according to project conventions.
   - Ensure failures are diagnosable.
   - Add logs, metrics, traces, or health signals only where useful and consistent with the codebase.
   - Do not leak secrets or sensitive data in logs or telemetry.

8. **Security and safety**
   - Validate inputs at trust boundaries.
   - Preserve authorization, authentication, tenant isolation, and permission checks.
   - Avoid injection risks, unsafe file paths, SSRF, secret exposure, unsafe deserialization, and insecure defaults.
   - Do not broaden privileges or network/file access unless required.

9. **Performance and resource lifecycle**
   - Avoid obvious inefficient algorithms on hot paths.
   - Do not introduce unbounded memory growth, goroutine/task/thread leaks, connection leaks, file descriptor leaks, timer leaks, or runaway background work.
   - Ensure resources are closed, canceled, cleaned up, or released in the correct order.
   - Add concurrency only when needed and bound it where possible.

10. **Dependencies**
    - Avoid new dependencies unless they materially reduce complexity or risk.
    - Prefer standard library or existing project dependencies when reasonable.
    - If adding a dependency, justify it and check maintenance, license, size, security, and transitive impact.

### Required review loop

After implementing, perform a self-review before finalizing:

1. List the files changed and why each change was necessary.
2. Check whether any change is unrelated to the task.
3. Check whether complexity increased unnecessarily.
4. Check whether any function/class/module became too large or too branchy.
5. Check whether errors, edge cases, cleanup, and cancellation are handled.
6. Check whether tests cover the meaningful behavior.
7. Check whether the implementation follows existing codebase conventions.
8. If any gate fails, fix it before finishing.

### Output expectations

When reporting the result, include:

1. What was implemented.
2. Why this is the smallest safe approach.
3. Codebase-quality risks considered.
4. Tests or checks run.
5. Any intentionally deferred cleanup or refactoring.
6. Any remaining risks or follow-up work.

Do not claim the work is done unless the product goal and the engineering quality gates are both satisfied.

## Existing-Codebase First

Before writing new code, inspect the existing codebase and identify the closest existing patterns for structure, naming, error handling, logging, testing, configuration, dependency wiring, and API shape.

New code must fit the current codebase unless the existing pattern is clearly broken.

Do not introduce a second way to solve the same problem. Prefer extending or reusing existing helpers, packages, conventions, and test styles.

Before adding a new abstraction, package, interface, service, helper, middleware, config object, or dependency, check whether the codebase already has an equivalent.

If the existing pattern is unhealthy, do not silently create a new competing pattern. Explain the problem, choose the smallest safe improvement, and keep the change localized.

Output before implementation:

* existing pattern found
* where it is used
* how the new code will follow it
* any intentional deviation and why

## Small Design Before Code

Before implementing, define the smallest design that solves the task.

Write a brief implementation sketch covering:

* the exact behavior being added or changed
* the minimal files/modules/functions that need to change
* the data flow
* the error paths
* the tests needed
* what will intentionally not be changed

Do not start coding until the implementation shape is clear.

Reject unnecessary scope expansion, unrelated cleanup, broad refactoring, speculative abstractions, future-proofing, new frameworks, new service boundaries, new background workers, new queues, new state machines, or new configuration unless they are required for the task.

If a simpler implementation can satisfy the requirement safely, choose it.

After implementation, verify that the final code still matches the small design. If the code grew beyond the design, explain why or reduce the change.

## New Code Complexity Budget

Every new function, class, module, package, component, or service must stay within a strict simplicity budget.

Prefer:

* short functions with one responsibility
* shallow control flow
* guard clauses over nested conditionals
* explicit data flow
* clear names over comments
* composition over large multipurpose objects
* boring code over clever code
* deterministic behavior over hidden side effects

Avoid:

* functions with many modes, flags, branches, or nested conditions
* large catch-all services
* premature interfaces
* generic helpers used only once
* hidden global state
* implicit lifecycle ownership
* mixed business logic, IO, parsing, validation, and presentation in one place
* concurrency without clear ownership, cancellation, and cleanup
* comments explaining complexity that should be removed instead

Before finalizing, check every new or heavily changed unit:

* Can it be understood without reading unrelated files?
* Does it have one clear responsibility?
* Are edge cases explicit?
* Are errors handled close to where they occur?
* Is lifecycle ownership obvious?
* Is the test surface small and meaningful?
* Would a future maintainer know where to change it?

If not, simplify before finishing.

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

## Implementation Change Report

After finishing implementation, explain the completed changes for a broad engineering audience. Do not assume the reader has deep knowledge of the codebase, its architecture, or its domain terminology.

Start with a concise overview of the behavior delivered and the part of the system it affects.

Then describe the changes file by file. For each changed file:

* explain the file's role in the system
* identify why the file needed to change
* describe every changed function, class, component, module, configuration block, or equivalent unit
* explain how behavior, data flow, control flow, errors, lifecycle, or external interactions changed
* state the engineering reason for the implementation choice
* note relevant tests, operational effects, compatibility considerations, and remaining risks

Use clear language, define unfamiliar terms, and provide enough context for an engineer outside the immediate team to understand the change. Prefer concrete behavior over implementation jargon.

Do not merely restate the diff, list filenames without explanation, or describe unchanged code. Group trivial or repetitive changes when that improves clarity, but do not omit meaningful changed units.

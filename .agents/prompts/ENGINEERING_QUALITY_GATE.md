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

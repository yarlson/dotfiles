## Engineering Quality Gate

Solve the requested task while preserving or improving maintainability, correctness, simplicity, testability, and long-term engineering health.

### Core rules

- **Keep the change small.** Modify only what the task requires. Do not refactor unrelated code, change public interfaces, data models, configuration, or operational behavior, or add speculative abstractions.
- **Preserve correctness.** Handle normal, boundary, and failure paths. Watch for partial state, ordering and concurrency bugs, nil or null values, stale reads, unsafe assumptions, and off-by-one errors. Make invalid states hard to represent where practical.
- **Keep responsibilities clear.** Avoid cleverness, hidden coupling, unnecessary indirection, and mixed concerns. Keep code boring and easy to modify.
- **Fit the codebase.** Follow existing conventions for structure, naming, errors, logging, testing, configuration, dependency wiring, and API shape. Do not introduce a second pattern without a clear reason.
- **Control complexity.** Prefer short units, shallow control flow, guard clauses, and explicit data flow. Add concurrency or complex runtime patterns only when a simpler design is insufficient.
- **Test the contract.** Add or update deterministic tests for changed behavior, important boundaries, failure paths, and cleanup. Do not weaken existing tests without a clear justification.
- **Surface failures.** Return, wrap, log, or expose errors according to project conventions. Add logs, metrics, traces, or health signals only when useful. Keep failures diagnosable without leaking secrets or sensitive data.
- **Protect trust boundaries.** Validate untrusted input and preserve authentication, authorization, tenant isolation, and permissions. Avoid injection, unsafe paths or deserialization, SSRF, secret exposure, insecure defaults, and unnecessary privilege or access.
- **Own resources.** Avoid inefficient work on hot paths and unbounded memory growth. Close, cancel, clean up, or release files, connections, timers, tasks, threads, and goroutines in the correct order. Bound concurrent or background work.
- **Avoid needless dependencies.** Prefer the standard library and existing dependencies. Add a dependency only when it materially reduces complexity or risk, and consider its maintenance, license, size, security, and transitive cost.

### Before finalizing

Review every changed file and confirm:

1. Every change is required for the task.
2. Complexity did not grow unnecessarily.
3. Changed units remain small, readable, and focused.
4. Errors, edge cases, cleanup, and cancellation are handled.
5. Tests cover the meaningful behavior.
6. The implementation follows existing conventions.

Fix any failed gate before claiming the work is complete.

### Report the result

Include:

- what was implemented
- why this is the smallest safe approach
- quality risks considered
- tests and checks run
- intentionally deferred cleanup
- remaining risks or follow-up work

## Existing Codebase First

Before writing code, inspect the closest existing patterns for structure, naming, errors, logging, testing, configuration, dependency wiring, and API shape.

- Extend healthy helpers, packages, conventions, and test styles instead of creating a second way to solve the same problem.
- Before adding an abstraction, package, interface, service, helper, middleware, configuration object, or dependency, check whether an equivalent already exists.
- If the existing pattern is unhealthy, explain the problem and make the smallest localized improvement. Do not silently introduce a competing pattern.

Before implementation, report:

- the existing pattern and where it is used
- how the new code will follow it
- any intentional deviation and why it is necessary

## Small Design Before Code

Define the smallest safe design before implementing. The sketch must cover:

- the exact behavior being changed
- the minimal files or units involved
- the data flow and error paths
- the tests needed
- what will remain unchanged

Reject unrelated cleanup, broad refactoring, speculative abstractions, future-proofing, new frameworks, service boundaries, workers, queues, state machines, or configuration unless the task requires them.

Choose the simplest design that safely satisfies the requirement. Before finalizing, confirm the implementation still matches the sketch; explain necessary growth or reduce the change.

## New Code Complexity Budget

Keep every new or heavily changed function, class, module, package, component, or service within a strict simplicity budget.

Prefer:

- one clear responsibility
- short units and shallow control flow
- guard clauses over nested conditions
- explicit data flow and lifecycle ownership
- clear names over explanatory comments
- composition over multipurpose objects
- deterministic behavior over hidden side effects

Avoid:

- modes, flags, branches, or nesting that obscure behavior
- catch-all services and premature interfaces
- generic helpers used only once
- hidden global state or implicit ownership
- mixing business logic, I/O, parsing, validation, and presentation
- concurrency without clear ownership, cancellation, bounds, and cleanup
- comments that explain complexity the code should remove

Before finalizing, confirm each changed unit is understandable without unrelated files, owns one responsibility, handles edge cases near their source, exposes a small test surface, and has an obvious place for future changes. Simplify anything that fails this check.

## Tests as Product Contracts

Tests must explain the behavior the system promises, not the mechanics used to arrange the test. A reader should quickly understand the condition, action, observable outcome, and what remains true on failure.

### Keep tests direct

- Arrange only inputs that define the scenario, perform one meaningful action, and assert the observable result and important side effects.
- Name tests in domain language so they read like behavioral contracts.
- Hide temporary directories, fake servers, process wiring, credentials, fixtures, and repetitive construction behind focused setup helpers. Keep scenario-defining values visible.
- Make each setup helper do one cohesive job, fail near a broken prerequisite, and register cleanup where it creates the resource.
- Keep test code shallow, deterministic, independent, and free of hidden mutable state or ordering dependencies.
- Prefer one behavior per test. Avoid conditionals that change a test's meaning and loops outside simple parameterized cases.

### Use tables only when they clarify

Use parameterized or table-based tests when named cases share the same setup, action, and assertions, especially for validation, parsing, mappings, and boundaries.

Keep case data focused on what varies. Separate materially different behaviors when combining them requires mode flags, branching assertions, different lifecycle expectations, or substantially different setup.

Do not force a table when a few direct tests make the contracts easier to understand.

### Verify observable behavior

Cover the smallest useful set of contracts:

- the normal path
- important input boundaries
- meaningful failure paths and preserved state
- cleanup and resource ownership
- externally visible side effects

Assert prerequisites separately when their failure would make later assertions misleading. Prefer explicit expected values over clever generation and failure messages that identify the broken contract.

Avoid real external services, arbitrary sleeps, timing assumptions, shared global state, and brittle snapshots unless the behavior requires them. Use the smallest realistic substitute at the system boundary; do not mock internal details merely to increase isolation.

### Test prompts and policies honestly

Sentence or substring presence does not prove that an agent follows a prompt or policy. Test the actual contract:

- test loading or assembly when that is the contract
- assert exact text only when wording is intentionally external and fixed
- use an integration test or evaluation when the contract is agent behavior

If behavior cannot be tested cheaply, state the remaining risk instead of adding a false-confidence string assertion.

### Before finalizing

Confirm that test names describe meaningful behavior, each test is understandable without reading its helpers first, setup does not hide the scenario, table cases share one execution path, success and failure contracts are clear, behavior-preserving refactors would keep tests valid, and the suite is deterministic and independent.

If a test is difficult to read, simplify the product boundary or setup before adding explanatory comments. Simplify any test that fails this review.

## Code Comment Policy

Use comments only to clarify the current code: invariants, constraints, non-obvious behavior, edge cases, safety or protocol rules, ownership, lifecycle, concurrency, ordering, or reasons an obvious approach is unsafe.

Prefer clear names and simple control flow over comments. Do not use comments as:

- decision logs or implementation history
- change summaries, PR explanations, or prose narratives
- apologies or commentary about removed code
- restatements of syntax or function names
- product commentary or future speculation
- TODOs without an owner or concrete completion condition
- “temporary” notes without a clear removal condition

A useful comment should explain what must remain true, what external contract forces the behavior, what edge case is intentional, or what would break if the code changed.

Before finalizing, review every touched comment. Remove stale, historical, obvious, or duplicated text; update comments that no longer match the code; and add a comment only when simplification cannot make the behavior clear.

Comments document the present system, not the journey that produced it.

## Implementation Change Report

Explain completed changes for a broad engineering audience. Start with a concise overview of the delivered behavior and the affected part of the system.

Describe each meaningfully changed file:

- its role and why it changed
- the changed functions, components, configuration, or equivalent units
- how behavior, data flow, control flow, errors, lifecycle, or external interactions changed
- why the implementation choice fits the codebase
- relevant tests, operational effects, compatibility concerns, and remaining risks

Keep detail proportional to the size and risk of the change. Group trivial or repetitive edits, but do not omit meaningful behavior. Use plain language, define unfamiliar terms, and describe concrete effects instead of restating the diff or listing filenames without context.

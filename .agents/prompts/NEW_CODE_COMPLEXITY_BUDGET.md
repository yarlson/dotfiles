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

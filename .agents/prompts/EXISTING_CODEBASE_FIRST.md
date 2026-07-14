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

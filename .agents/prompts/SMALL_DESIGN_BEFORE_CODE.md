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

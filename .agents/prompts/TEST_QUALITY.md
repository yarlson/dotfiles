## Tests as Product Contracts

Tests should explain the behavior the system promises, not the mechanics used to set up the test.

Write tests so a reader can quickly answer:

* What behavior is guaranteed?
* Under what conditions?
* What outcome is observable?
* What must remain true when the operation fails?

### Test structure

Prefer tests with a short, linear flow:

1. Arrange only the inputs relevant to the behavior.
2. Perform one meaningful action.
3. Assert the observable outcome and important side effects.

Use names that describe behavior in domain language. A test name should read like a product or system contract, not a method name with `works` appended.

Keep setup mechanics out of the contract. Hide temporary directories, fake servers, process wiring, credentials, fixtures, and repetitive object construction behind focused setup helpers. Keep values that materially define the scenario visible in the test.

Setup helpers must:

* have names that reveal the scenario they create
* do one cohesive setup job
* fail close to the broken prerequisite
* register cleanup where the resource is created
* avoid hiding the behavior being tested
* avoid becoming a generic testing framework

### Parameterized and table-based tests

Use parameterized or table-based tests when several named cases share the same setup, action, and assertions. They are especially useful for validation rules, parsing, mappings, and boundary values.

Every case should have a descriptive name. Keep the case data small and focused on what varies.

Do not force materially different behaviors into one table. Keep cases separate when combining them requires mode flags, branching assertions, different lifecycle expectations, or substantially different setup. A table that needs complex control flow is harder to understand than a few direct tests.

### Complexity and readability

Test code is production code. Keep it simple:

* prefer one behavior per test
* keep control flow shallow
* avoid loops outside simple parameterized cases
* avoid conditionals that change the meaning of a test
* avoid hidden mutable state and ordering dependencies
* prefer explicit expected values over clever expected-value generation
* keep failure messages specific enough to diagnose the broken contract

If a test is difficult to read, first simplify the product boundary or test setup. Do not compensate with comments that narrate complicated test code.

### What to verify

Test observable behavior rather than private implementation details. Cover the smallest useful set of contracts:

* the normal path
* important input boundaries
* meaningful failure paths
* cleanup and resource ownership
* preserved state when an operation must not mutate or delete something
* externally visible side effects

Assert prerequisites separately from independent outcomes so setup failures do not produce misleading secondary failures.

Prefer deterministic tests. Avoid real external services, arbitrary sleeps, timing assumptions, shared global state, and brittle snapshots unless the behavior specifically requires them. Use the smallest realistic substitute at the system boundary, and do not mock internal details merely to increase isolation.

### Prompt and policy text

Do not treat the presence of a sentence or substring in a prompt, policy, template, or configuration file as proof that the system follows it. A contradictory prompt can contain the expected words, while harmless rewording or formatting can break a string assertion without changing behavior.

Test the actual contract:

* if the contract is that text loads or is assembled correctly, test loading or assembly
* if exact wording is intentionally an external contract, assert the text directly and make that constraint explicit
* if the contract is agent behavior, observe the resulting tool calls, outputs, state changes, or safety boundary through an integration test or evaluation

Do not add substring assertions as a proxy when the real behavior cannot be tested cheaply. State the untested risk instead of creating false confidence.

### Review checklist

Before finalizing tests, check:

1. Do the test names describe behavior meaningful to a product or engineering reader?
2. Can each test be understood without reading its helpers first?
3. Is irrelevant setup hidden while scenario-defining input remains visible?
4. Are table-based cases used only where the execution and assertion flow is identical?
5. Are success, failure, and cleanup contracts clear?
6. Would an implementation refactor that preserves behavior leave the tests valid?
7. Are the tests deterministic and independent?
8. Do prompt or policy tests verify the real contract rather than merely checking for expected words?

If not, simplify the tests before finishing.

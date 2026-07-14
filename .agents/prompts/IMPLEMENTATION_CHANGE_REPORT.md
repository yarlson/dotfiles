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

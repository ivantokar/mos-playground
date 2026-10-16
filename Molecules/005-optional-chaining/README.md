# Molecules of Swift #005 — Optional Chaining: Let Absence Flow Through an Expression

Explore how `?.` reads, calls, and assigns through optional values, and what happens when a link is missing.

## Run

From the repository root:

```sh
swift build
swift run molecule-005
```

## What you will learn

- A chain stops at the first `nil`, but preserves values such as `false` and an empty string.
- Chained assignment and method calls skip evaluating their arguments when the receiver is missing.
- Chained dictionary mutation updates existing values but does not create missing keys.
- `??` handles `nil`, not invalid or empty values.
- Optional chaining does not prevent invalid indexing or forced-unwrap traps.

## Explore the code

Read [main.swift](main.swift) in order. Each section explains the behavior, shows the result, and gives a specific change to try. Intentionally unsafe examples are commented out.

**Read the article:** [Optional Chaining: Let Absence Flow Through an Expression](https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression)

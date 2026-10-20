# Molecules of Swift #006 — Nil Coalescing: Provide Defaults Without Branching

Explore how `??` chooses a value, delays fallback work, composes with optional chaining, and differs from validation or inserting a default into a dictionary.

## Article

[Nil Coalescing: Provide Defaults Without Branching](https://ivantokar.com/posts/nil-coalescing-provide-defaults-without-branching/)

## Run

From the repository root:

```sh
swift build
swift run molecule-006
```

## What you will learn

- `false`, `""`, and an empty collection are present values, not `nil`.
- A fallback-producing function is not called when the optional already holds a value.
- `account?.preferences?.language ?? "en"` combines optional chaining with one final fallback.
- A dictionary lookup with `?? 0` does not insert a key, whereas `dictionary[key, default: 0]` can.
- A fallback like `Int(raw) ?? 0` can conceal invalid input; an explicit `if let` keeps validation visible.

## Explore the code

Read [main.swift](main.swift) in order. Each numbered section shows observable output and includes a specific `TRY` experiment with a predicted change.


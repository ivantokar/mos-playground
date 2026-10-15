# Molecules of Swift #005 — Optional Chaining

An executable lesson about reading and working with optional values.

## Run

From the repository root:

```sh
swift build
swift run molecule-005
```

Read [main.swift](main.swift) from top to bottom while running it. Each section explains the idea, shows a short example, includes the expected output, and suggests a change to try.

## Learning path

1. **Read an optional property.** Use `?.` to read a property only when the value exists. Use `??` for a fallback.
2. **Follow nested values.** See how multiple optional links still produce a single optional result.
3. **Use optional binding.** Compare a quick read with `if let` when you need the value.
4. **Update existing dictionary data.** Change an array under an existing key without creating a missing entry.
5. **Under the Hood.** Observe how an optional assignment skips evaluating its right-hand side when the target is `nil`.

## How to learn from it

Run the program once. Then follow the **Try it** comments, changing only one value at a time. Predict the output before each run.

The code prints what happens instead of hiding the lesson behind assertions. For deeper technical detail, read the [chapter](https://github.com/ivantokar/ivantokar.com/blob/article/optional-chaining-let-absence-flow-through-an-expression/apps/website/src/posts/optional-chaining-let-absence-flow-through-an-expression.mdx).

## Further reading

[Swift Book — Optional Chaining](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/optionalchaining/)

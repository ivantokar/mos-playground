// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #002
// Tuple Patterns: Destructure Values Where You Use Them
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/tuple-patterns-destructure-values-where-you-use-them
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Explore. Change things. Break things. Learn why.

// MARK: - 1. Decompose a tuple into local bindings
// WHY: A tuple pattern assigns each element to a local constant in one declaration.
// TRY: Change response.message and check which binding receives the new text.

let response = (status: 200, message: "OK")
let (status, message) = response
print(status, message)

// MARK: - 2. Ignore a position with the wildcard pattern
// WHY: The wildcard skips the name field without creating a local variable.
// TRY: Replace _ with name and print all three bindings.

let user = (id: 42, name: "Mira", isAdmin: true)
let (id, _, isAdmin) = user
print(id, isAdmin)

// MARK: - 3. Destructure directly in a for-in loop
// WHY: The for-in pattern unpacks each tuple before the loop body runs.
// TRY: Print only entries with score >= 90 using an if condition.

let scores = [
    (name: "Mira", score: 91),
    (name: "Noah", score: 84),
    (name: "Ava", score: 97),
]

for (name, score) in scores {
    print("\(name): \(score)")
}

// MARK: - 4. Mix values, ranges, and wildcards
// WHY: Cases run in order, so axis cases match before the box range.
// TRY: Change point to (3, 4), then (0, 0); predict each branch.

let point = (x: 0, y: 4)

switch point {
case (0, 0): print("origin")
case (0, _): print("y-axis")
case (_, 0): print("x-axis")
case (-5...5, -5...5): print("inside the box")
default: print("outside")
}

// MARK: - 5. Bind values only when the pattern matches
// WHY: A let pattern binds a coordinate only for the selected case.
// TRY: Change anotherPoint to (0, 8) and then (8, 8).

let anotherPoint = (x: 8, y: 0)

switch anotherPoint {
case (let x, 0): print("x-axis at \(x)")
case (0, let y): print("y-axis at \(y)")
case let (x, y): print("elsewhere at \(x), \(y)")
}

// MARK: - 6. Refine a pattern with where
// WHY: The where clause checks a condition using values bound by the tuple pattern.
// TRY: Change vector to (3, 3), then (3, 4).

let vector = (x: 3, y: -3)

switch vector {
case let (x, y) where x == y: print("main diagonal")
case let (x, y) where x == -y: print("opposite diagonal")
case let (x, y): print("ordinary vector: \(x), \(y)")
}

// MARK: - 7. The same pattern language works with if case
// WHY: if case uses the same matching rules without needing a full switch.
// TRY: Change sample.y to 99; the print should disappear.

let sample = (x: 12, y: 100)

if case (let x, 100) = sample {
    print("y = 100 at x = \(x)")
}

// MARK: - 8. Manual compiler experiment
// WHY: A tuple pattern must have the same number of positions as its value.
// TRY: Uncomment the invalid binding, inspect the compiler error, then comment it out.

// Uncomment to see the diagnostic for a pattern whose shape does not match.
//
// let (code, text, extra) = response

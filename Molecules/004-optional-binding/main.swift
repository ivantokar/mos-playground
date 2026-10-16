// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #004
// Optional Binding: Turn an Optional Into a Value
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/optional-binding-turn-an-optional-into-a-value
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Explore. Change things. Break things. Learn why.

// Read the examples in order. Each printed value illustrates the rule nearby.

print("Molecule #004 — Optional Binding")

// MARK: - 1. Parse a value
// WHY: Int returns an optional: if let gives the successful branch a usable Int.
// TRY: Change "42" to "forty-two" and compare the branches.

// A successful binding creates a non-optional local value.
if let number = Int("42") {
    print("Observation 1:", number + 1 == 43)
}
if let number = Int("invalid") {
    print("Unexpected: \(number)")
} else {
    print("Invalid input was skipped.")
}

// MARK: - 2. Short binding
// WHY: if let nickname binds a non-optional String only inside the if body.
// TRY: Set nickname to nil and observe the skipped body.

// Short binding shadows the optional only inside the if branch.
let nickname: String? = "Mira"
if let nickname {
    print("Observation 2:", nickname.uppercased() == "MIRA")
}
print("Observation 3:", nickname == "Mira")

// MARK: - 3. Presence versus validity
// WHY: Zero and empty text are present values; binding alone does not validate them.
// TRY: Change empty to "Swift" and compare both conditions.

// Presence does not imply nonempty or nonzero.
let zero: Int? = 0
let empty: String? = ""
if let zero { print("Observation 4:", zero == 0) }
if let empty { print("Observation 5:", empty.isEmpty) }
if let empty, !empty.isEmpty {
    print("Only a nonempty value reaches this line: \(empty)")
}

// MARK: - 4. Short-circuit evaluation
// WHY: Conditions are evaluated from left to right; laterValue is not called after a failed binding.
// TRY: Change missing to 2 and predict how calls changes.

// Comma-separated conditions stop evaluating after a failure.
// Top-level variables in main.swift are main-actor isolated in Swift 6,
// so the function that mutates the counter has to be isolated too.
var calls = 0
@MainActor func laterValue() -> Int? {
    calls += 1
    return 9
}
let missing: Int? = nil
if let first = missing, let second = laterValue(), first < second {
    print("Unexpected: \(first) \(second)")
}
print("Observation 6:", calls == 0)
let present: Int? = 4
if let first = present, let second = laterValue(), first < second {
    print("Observation 7:", first == 4 && second == 9)
}
print("Observation 8:", calls == 1)

// MARK: - 5. Dependent bindings
// WHY: Later conditions can use earlier bindings to validate a range.
// TRY: Try parsedRange("3", "2") and parsedRange("three", "7").

// Earlier bindings are available in later conditions.
func parsedRange(_ lower: String, _ upper: String) -> ClosedRange<Int>? {
    if let start = Int(lower), let end = Int(upper), start <= end {
        return start...end
    }
    return nil
}
print("Observation 9:", parsedRange("3", "7") == 3...7)
print("Observation 10:", parsedRange("7", "3") == nil)
print("Observation 11:", parsedRange("three", "7") == nil)

// MARK: - 6. Mutable local binding
// WHY: if var creates a mutable local copy; original remains unchanged.
// TRY: Replace if var with if let and inspect the compiler diagnostic.

// if var changes only the local copy, not the outer optional.
let original: String? = "Draft"
if var title = original {
    title += "!"
    print("Observation 12:", title == "Draft!")
}
print("Observation 13:", original == "Draft")

// MARK: - 7. Repeated binding
// WHY: while let unwraps each iterator result until next() returns nil.
// TRY: Add a third name and predict the collected array.

// while let extracts successive optional iterator results.
var iterator = ["Mira", "Noah"].makeIterator()
var collected: [String] = []
while let name = iterator.next() {
    collected.append(name)
}
print("Observation 14:", collected == ["Mira", "Noah"])
print("Observation 15:", iterator.next() == nil)

// MARK: - 8. Nested optionals
// WHY: Binding unwraps one optional layer, not all nested layers at once.
// TRY: Change nested from .some(nil) to nil and see whether the branch executes.

// Optional binding unwraps one layer, even for nested optionals.
let nested: Int?? = .some(nil)
if let inner = nested {
    print("Observation 16:", inner == nil)
}

// MARK: - 9. Compiler experiments
// WHY: The commented invalid examples demonstrate scope, mutability, and required unwrapping.
// TRY: Uncomment one example at a time and inspect the compiler diagnostic.

// Manual compiler experiments. Uncomment one block at a time.
// 1. Optional methods need unwrapping:
// let maybe: String? = "Mira"
// print(maybe.uppercased()) // Error: optional value must be unwrapped.
//
// 2. A bound name cannot escape the if branch:
// if let value = Int("42") { print(value) }
// print(value) // Error: cannot find value in scope.
//
// 3. if let creates a constant, not a mutable variable:
// if let value = Int("42") { value += 1 } // Error: let constant.
//
// 4. guard else must exit the enclosing scope:
// func invalidGuard(_ value: Int?) {
//     guard let value else { print("missing") } // Error: else must not fall through.
//     print(value)
// }

print("End of lesson — try changing an input and observe the output.")

// Learning exercise: choose one example above, change a single input,
// predict the result, and run the executable to compare.

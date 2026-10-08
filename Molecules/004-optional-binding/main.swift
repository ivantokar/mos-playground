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

print("Molecule #004 — Optional Binding")

// A successful binding creates a non-optional local value.
if let number = Int("42") {
    assert(number + 1 == 43)
}
if let number = Int("invalid") {
    print("Unexpected: \(number)")
} else {
    print("Invalid input was skipped.")
}

// Short binding shadows the optional only inside the if branch.
let nickname: String? = "Mira"
if let nickname {
    assert(nickname.uppercased() == "MIRA")
}
assert(nickname == "Mira")

// Presence does not imply nonempty or nonzero.
let zero: Int? = 0
let empty: String? = ""
if let zero { assert(zero == 0) }
if let empty { assert(empty.isEmpty) }
if let empty, !empty.isEmpty {
    print("Only a nonempty value reaches this line: \(empty)")
}

// Comma-separated conditions stop evaluating after a failure.
var calls = 0
func laterValue() -> Int? {
    calls += 1
    return 9
}
let missing: Int? = nil
if let first = missing, let second = laterValue(), first < second {
    print("Unexpected: \(first) \(second)")
}
assert(calls == 0)
let present: Int? = 4
if let first = present, let second = laterValue(), first < second {
    assert(first == 4 && second == 9)
}
assert(calls == 1)

// Earlier bindings are available in later conditions.
func parsedRange(_ lower: String, _ upper: String) -> ClosedRange<Int>? {
    if let start = Int(lower), let end = Int(upper), start <= end {
        return start...end
    }
    return nil
}
assert(parsedRange("3", "7") == 3...7)
assert(parsedRange("7", "3") == nil)
assert(parsedRange("three", "7") == nil)

// if var changes only the local copy, not the outer optional.
let original: String? = "Draft"
if var title = original {
    title += "!"
    assert(title == "Draft!")
}
assert(original == "Draft")

// while let extracts successive optional iterator results.
var iterator = ["Mira", "Noah"].makeIterator()
var collected: [String] = []
while let name = iterator.next() {
    collected.append(name)
}
assert(collected == ["Mira", "Noah"])
assert(iterator.next() == nil)

// Optional binding unwraps one layer, even for nested optionals.
let nested: Int?? = .some(nil)
if let inner = nested {
    assert(inner == nil)
}

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

print("All Molecule #004 checks passed.")

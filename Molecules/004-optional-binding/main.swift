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

// MARK: - 1. Bind only when conversion succeeds
// WHAT: Int(String) returns Int? because parsing can fail.
// WHY: if let gives the success branch an Int, without force-unwrapping.
// EXPECT: "Next number: 43", then "Invalid number".

if let number = Int("42") {
    print("Next number:", number + 1)
}
if let number = Int("invalid") {
    print("Parsed:", number)
} else {
    print("Invalid number")
}
// TRY: Replace "42" with "forty-two". Which branch will run?

// MARK: - 2. Short binding keeps the same name
// WHAT: if let nickname creates a nonoptional value inside its branch.
// WHY: You can use the familiar name without repeatedly unwrapping.
// EXPECT: "MIRA", followed by Optional("Mira") outside the branch.

let nickname: String? = "Mira"
if let nickname {
    print("Uppercase nickname:", nickname.uppercased())
}
print("Original optional:", nickname as Any)
// TRY: Set nickname to nil and observe which print disappears.

// MARK: - 3. Presence is not validation
// WHAT: Optional binding tests for nil, not for zero or empty text.
// WHY: A present value may still fail your application's requirements.
// EXPECT: Both values bind; the empty string fails the extra condition.

let zero: Int? = 0
let empty: String? = ""
if let zero { print("Zero is present:", zero) }
if let empty { print("Empty text is present:", empty.isEmpty) }
if let empty, !empty.isEmpty {
    print("Nonempty text:", empty)
} else {
    print("No nonempty text")
}
// TRY: Change empty to "Swift" and compare both checks.

// MARK: - 4. Conditions stop after the first failure
// WHAT: Comma-separated conditions are evaluated from left to right.
// WHY: Later calls are skipped when an earlier binding fails.
// EXPECT: The counter stays 0 for missing, then becomes 1 for present.

var calls = 0
@MainActor func laterValue() -> Int? {
    calls += 1
    return 9
}
let missing: Int? = nil
if let first = missing, let second = laterValue(), first < second {
    print("Pair:", first, second)
}
print("Calls after nil:", calls)
let present: Int? = 4
if let first = present, let second = laterValue(), first < second {
    print("Pair:", first, second)
}
print("Calls after value:", calls)
// TRY: Change missing to 2 and predict how many times laterValue runs.

// MARK: - 5. Later bindings can use earlier values
// WHAT: Each successful binding becomes available to subsequent conditions.
// WHY: Parse and validate a range without force-unwrapping either bound.

func parsedRange(_ lower: String, _ upper: String) -> ClosedRange<Int>? {
    if let start = Int(lower), let end = Int(upper), start <= end {
        return start...end
    }
    return nil
}
print("Valid range:", parsedRange("3", "7") as Any)
print("Reversed range:", parsedRange("7", "3") as Any)
print("Invalid number:", parsedRange("three", "7") as Any)
// EXPECT: Optional(ClosedRange(3...7)), nil, nil.
// TRY: Change the second bound to "2" and explain why the range disappears.

// MARK: - 6. if var changes a local copy
// WHAT: if var binds a mutable copy of the unwrapped value.
// WHY: Changing that local variable does not mutate the original optional.

let original: String? = "Draft"
if var title = original {
    title += "!"
    print("Local title:", title)
}
print("Original title:", original as Any)
// EXPECT: "Draft!" and Optional("Draft").
// TRY: Change if var to if let and inspect the compiler diagnostic.

// MARK: - 7. while let unwraps successive values
// WHAT: Iterator.next() returns nil when there are no more elements.
// WHY: while let ends naturally without a separate index or sentinel.

var iterator = ["Mira", "Noah"].makeIterator()
while let name = iterator.next() {
    print("Next name:", name)
}
print("After iteration:", iterator.next() as Any)
// EXPECT: Mira, Noah, then nil.
// TRY: Add "Ava" and predict the extra line.

// MARK: - 8. Binding removes only one optional layer
// WHAT: Int?? can hold an outer value whose inner value is nil.
// WHY: One if let does not unwrap every optional layer.

let nested: Int?? = .some(nil)
if let inner = nested {
    print("Outer optional exists; inner value:", inner as Any)
} else {
    print("Outer optional is missing")
}
// EXPECT: The first branch runs and prints nil.
// TRY: Replace .some(nil) with nil, then with .some(.some(7)).

// MARK: - 9. Compiler experiments
// Uncomment ONE example at a time to see Swift enforce the rule.

// let maybe: String? = "Mira"
// print(maybe.uppercased()) // An optional must be unwrapped.
//
// if let value = Int("42") { print(value) }
// print(value) // The binding does not escape its if branch.
//
// if let value = Int("42") { value += 1 } // if let creates a constant.
//
// func invalidGuard(_ value: Int?) {
//     guard let value else { print("missing") } // guard else must exit.
//     print(value)
// }

// Takeaway: binding proves that a value exists; validation is a separate step.
// Final experiment: Set each optional to nil and predict which code is skipped.

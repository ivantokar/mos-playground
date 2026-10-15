// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #004
// Optional Binding: Turn an Optional Into a Value
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/optional-binding-turn-an-optional-into-a-value
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// An optional may hold a value or nil. if let opens the present case.

print("1. Convert user input")
let input = "42"
if let number = Int(input) {
    print(number + 1) // 43
} else {
    print("Please enter a number")
}
// WHY: Int(_:) returns Int? because parsing can fail.
// TRY: change input to "forty-two". Which branch runs?

print("\n2. Use a shorter binding")
let nickname: String? = "Mira"
if let nickname {
    print(nickname.uppercased()) // MIRA
}
// WHY: inside the branch, nickname is a String rather than String?.
// TRY: set nickname to nil. The branch is skipped.

print("\n3. Present does not mean nonempty")
let maybeText: String? = ""
if let text = maybeText {
    print("Present, length: \(text.count)") // Present, length: 0
}
if let text = maybeText, !text.isEmpty {
    print("Nonempty: \(text)")
} else {
    print("Missing or empty") // this branch
}
// WHY: optional binding checks for nil, not for valid content.
// TRY: change "" to "Swift" and compare the output.

print("\n4. Combine dependent checks")
func numberRange(_ startText: String, _ endText: String) -> ClosedRange<Int>? {
    if let start = Int(startText),
       let end = Int(endText),
       start <= end {
        return start...end
    }
    return nil
}
if let range = numberRange("3", "7") {
    print(range.contains(5)) // true
}
print(numberRange("7", "3") as Any) // nil
// WHY: later conditions can use earlier bound values.
// TRY: pass "three" as the first argument.

print("\n5. Change a local copy")
let original: String? = "Draft"
if var title = original {
    title += "!"
    print(title) // Draft!
}
print(original ?? "Missing") // Draft
// WHY: if var creates a mutable local binding, not a mutation of original.
// TRY: replace if var with if let and see why title += fails.

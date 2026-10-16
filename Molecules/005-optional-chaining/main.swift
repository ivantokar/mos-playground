// Molecules of Swift #005 — Optional Chaining
// https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression

print("Molecule #005 — Optional Chaining")

// MARK: - 1. Read optional properties
// WHAT: Explore read optional properties through the example below.
// WHY: A chain stops when the account or preferences is nil; false remains a present Bool value.
// TRY: Change notificationsEnabled to true, then set account to nil.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

struct Preferences { var notificationsEnabled: Bool }
struct Account { var preferences: Preferences? }

let account: Account? = Account(preferences: Preferences(notificationsEnabled: false))
let enabled: Bool? = account?.preferences?.notificationsEnabled
print("Example 1 — enabled == false:", enabled == false)
let missingAccount: Account? = nil
print("Example 2 — missingAccount?.preferences?.notificationsEnabled == nil:", missingAccount?.preferences?.notificationsEnabled == nil)
let noPreferences: Account? = Account(preferences: nil)
print("Example 3 — noPreferences?.preferences?.notificationsEnabled == nil:", noPreferences?.preferences?.notificationsEnabled == nil)

// MARK: - 2. Follow nested properties
// WHAT: Explore follow nested properties through the example below.
// WHY: Each optional link can stop the read; the final result remains String? or Int?.
// TRY: Change city to nil and compare city and length.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

struct Address { var city: String? }
struct Person { var address: Address? }
let person: Person? = Person(address: Address(city: "Kyiv"))
let city: String? = person?.address?.city
let length: Int? = person?.address?.city?.count
print("Example 4 — city == 'Kyiv':", city == "Kyiv")
print("Example 5 — length == 4:", length == 4)
let personWithoutCity: Person? = Person(address: Address(city: nil))
print("Example 6 — personWithoutCity?.address?.city?.count == nil:", personWithoutCity?.address?.city?.count == nil)

// MARK: - 3. Optional assignment
// WHAT: Explore optional assignment through the example below.
// WHY: When note is nil, Swift skips evaluating the right-hand side; a successful assignment returns Void?.
// TRY: Give note a value before the first assignment and predict constructionCount.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

struct Note { var text: String }
var note: Note? = nil
var constructionCount = 0
let makeText: () -> String = {
    constructionCount += 1
    return "Ready"
}
note?.text = makeText()
print("Example 7 — constructionCount == 0:", constructionCount == 0)
let missedAssignment: Void? = (note?.text = makeText())
print("Example 8 — missedAssignment == nil:", missedAssignment == nil)
print("Example 9 — constructionCount == 0:", constructionCount == 0)
note = Note(text: "Draft")
let successfulAssignment: Void? = (note?.text = makeText())
print("Example 10 — successfulAssignment != nil:", successfulAssignment != nil)
print("Example 11 — constructionCount == 1:", constructionCount == 1)
print("Example 12 — note?.text == 'Ready':", note?.text == "Ready")

// MARK: - 4. Optional method calls
// WHAT: Explore optional method calls through the example below.
// WHY: Arguments are not evaluated when the optional receiver is nil; the call result is Void?.
// TRY: Initialize mailbox before the first append and observe the counter.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

struct Mailbox {
    var messages: [String] = []
    mutating func append(_ message: String) {
        messages.append(message)
    }
}
var mailbox: Mailbox? = nil
var messageConstructionCount = 0
let makeMessage: () -> String = {
    messageConstructionCount += 1
    return "Hello"
}
mailbox?.append(makeMessage())
print("Example 13 — messageConstructionCount == 0:", messageConstructionCount == 0)
print("Example 14 — mailbox?.append('Ignored') == nil:", mailbox?.append("Ignored") == nil)
mailbox = Mailbox()
let called: Void? = mailbox?.append(makeMessage())
print("Example 15 — called != nil:", called != nil)
print("Example 16 — messageConstructionCount == 1:", messageConstructionCount == 1)
print("Example 17 — mailbox?.messages == ['Hello']:", mailbox?.messages == ["Hello"])

// MARK: - 5. Update existing dictionary values
// WHAT: Explore update existing dictionary values through the example below.
// WHY: The dictionary subscript returns an optional array; chaining does not create missing keys.
// TRY: Insert grades["Leo"] = [] before append and inspect the result.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

var grades = ["Ada": [80, 90]]
grades["Ada"]?.append(100)
grades["Leo"]?.append(100)
print("Example 18 — grades['Ada'] == [80, 90, 100]:", grades["Ada"] == [80, 90, 100])
print("Example 19 — grades['Leo'] == nil:", grades["Leo"] == nil)

// MARK: - 6. Combine chaining with fallback
// WHAT: Explore combine chaining with fallback through the example below.
// WHY: The ?? operator handles nil, not an empty string; if let can add explicit validation.
// TRY: Change the city to an empty string and compare the two approaches.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

let cityLabel = person?.address?.city ?? "Unknown"
print("Example 20 — cityLabel == 'Kyiv':", cityLabel == "Kyiv")
let unknownCityLabel = personWithoutCity?.address?.city ?? "Unknown"
print("Example 21 — unknownCityLabel == 'Unknown':", unknownCityLabel == "Unknown")
let emptyCity: Person? = Person(address: Address(city: ""))
print("Example 22 — emptyCity?.address?.city ?? 'Unknown' == '':", emptyCity?.address?.city ?? "Unknown" == "")
if let city = person?.address?.city, !city.isEmpty {
    print("Example 23 — city == 'Kyiv':", city == "Kyiv")
}

// MARK: - 7. Unsafe operations remain unsafe
// WHAT: Explore unsafe operations remain unsafe through the example below.
// WHY: Optional chaining does not validate indices or prevent forced-unwrap traps.
// TRY: Read the commented examples; do not run trapping examples in the normal lesson.
// EXPECT: Compare the printed observation before and after this edit; the value on each line comes from the expression shown in its label.

// Manual compiler and runtime experiments; do not enable in the normal run:
// let impossible: Bool = missingAccount?.preferences?.notificationsEnabled
//   A Bool? cannot be used as a non-optional Bool.
// let unsafeIndex = grades["Ada"]?[99]
//   A present array still traps for an out-of-bounds index.
// let unsafeUnwrap = personWithoutCity?.address?.city!
//   A forced unwrap can still trap when the value is nil.

print("End of lesson — try changing an input and observe the output.")

// Learning exercise: choose one example above, change a single input,
// predict the result, and run the executable to compare.

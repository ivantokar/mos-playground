// Molecules of Swift #005 — Optional Chaining
// https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression

print("Molecule #005 — Optional Chaining")

// MARK: - 1. Read optional properties
// WHY: A chain stops when the account or preferences is nil; false remains a present Bool value.
// TRY: Change notificationsEnabled to true, then set account to nil.

struct Preferences { var notificationsEnabled: Bool }
struct Account { var preferences: Preferences? }

let account: Account? = Account(preferences: Preferences(notificationsEnabled: false))
let enabled: Bool? = account?.preferences?.notificationsEnabled
assert(enabled == false)
let missingAccount: Account? = nil
assert(missingAccount?.preferences?.notificationsEnabled == nil)
let noPreferences: Account? = Account(preferences: nil)
assert(noPreferences?.preferences?.notificationsEnabled == nil)

// MARK: - 2. Follow nested properties
// WHY: Each optional link can stop the read; the final result remains String? or Int?.
// TRY: Change city to nil and compare city and length.

struct Address { var city: String? }
struct Person { var address: Address? }
let person: Person? = Person(address: Address(city: "Kyiv"))
let city: String? = person?.address?.city
let length: Int? = person?.address?.city?.count
assert(city == "Kyiv")
assert(length == 4)
let personWithoutCity: Person? = Person(address: Address(city: nil))
assert(personWithoutCity?.address?.city?.count == nil)

// MARK: - 3. Optional assignment
// WHY: When note is nil, Swift skips evaluating the right-hand side; a successful assignment returns Void?.
// TRY: Give note a value before the first assignment and predict constructionCount.

struct Note { var text: String }
var note: Note? = nil
var constructionCount = 0
let makeText: () -> String = {
    constructionCount += 1
    return "Ready"
}
note?.text = makeText()
assert(constructionCount == 0)
let missedAssignment: Void? = (note?.text = makeText())
assert(missedAssignment == nil)
assert(constructionCount == 0)
note = Note(text: "Draft")
let successfulAssignment: Void? = (note?.text = makeText())
assert(successfulAssignment != nil)
assert(constructionCount == 1)
assert(note?.text == "Ready")

// MARK: - 4. Optional method calls
// WHY: Arguments are not evaluated when the optional receiver is nil; the call result is Void?.
// TRY: Initialize mailbox before the first append and observe the counter.

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
assert(messageConstructionCount == 0)
assert(mailbox?.append("Ignored") == nil)
mailbox = Mailbox()
let called: Void? = mailbox?.append(makeMessage())
assert(called != nil)
assert(messageConstructionCount == 1)
assert(mailbox?.messages == ["Hello"])

// MARK: - 5. Update existing dictionary values
// WHY: The dictionary subscript returns an optional array; chaining does not create missing keys.
// TRY: Insert grades["Leo"] = [] before append and inspect the result.

var grades = ["Ada": [80, 90]]
grades["Ada"]?.append(100)
grades["Leo"]?.append(100)
assert(grades["Ada"] == [80, 90, 100])
assert(grades["Leo"] == nil)

// MARK: - 6. Combine chaining with fallback
// WHY: The ?? operator handles nil, not an empty string; if let can add explicit validation.
// TRY: Change the city to an empty string and compare the two approaches.

let cityLabel = person?.address?.city ?? "Unknown"
assert(cityLabel == "Kyiv")
let unknownCityLabel = personWithoutCity?.address?.city ?? "Unknown"
assert(unknownCityLabel == "Unknown")
let emptyCity: Person? = Person(address: Address(city: ""))
assert(emptyCity?.address?.city ?? "Unknown" == "")
if let city = person?.address?.city, !city.isEmpty {
    assert(city == "Kyiv")
}

// MARK: - 7. Unsafe operations remain unsafe
// WHY: Optional chaining does not validate indices or prevent forced-unwrap traps.
// TRY: Read the commented examples; do not run trapping examples in the normal lesson.

// Manual compiler and runtime experiments; do not enable in the normal run:
// let impossible: Bool = missingAccount?.preferences?.notificationsEnabled
//   A Bool? cannot be used as a non-optional Bool.
// let unsafeIndex = grades["Ada"]?[99]
//   A present array still traps for an out-of-bounds index.
// let unsafeUnwrap = personWithoutCity?.address?.city!
//   A forced unwrap can still trap when the value is nil.

print("All Molecule #005 checks passed.")

// Learning exercise: choose one example above, change a single input,
// predict the result, and run the executable to compare.

// Molecules of Swift #005 — Optional Chaining
// https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression

print("Molecule #005 — Optional Chaining")

struct Preferences { var notificationsEnabled: Bool }
struct Account { var preferences: Preferences? }

let account: Account? = Account(preferences: Preferences(notificationsEnabled: false))
let enabled: Bool? = account?.preferences?.notificationsEnabled
assert(enabled == false)
let missingAccount: Account? = nil
assert(missingAccount?.preferences?.notificationsEnabled == nil)
let noPreferences: Account? = Account(preferences: nil)
assert(noPreferences?.preferences?.notificationsEnabled == nil)

struct Address { var city: String? }
struct Person { var address: Address? }
let person: Person? = Person(address: Address(city: "Kyiv"))
let city: String? = person?.address?.city
let length: Int? = person?.address?.city?.count
assert(city == "Kyiv")
assert(length == 4)
let personWithoutCity: Person? = Person(address: Address(city: nil))
assert(personWithoutCity?.address?.city?.count == nil)

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

var grades = ["Ada": [80, 90]]
grades["Ada"]?.append(100)
grades["Leo"]?.append(100)
assert(grades["Ada"] == [80, 90, 100])
assert(grades["Leo"] == nil)

let cityLabel = person?.address?.city ?? "Unknown"
assert(cityLabel == "Kyiv")
let unknownCityLabel = personWithoutCity?.address?.city ?? "Unknown"
assert(unknownCityLabel == "Unknown")
let emptyCity: Person? = Person(address: Address(city: ""))
assert(emptyCity?.address?.city ?? "Unknown" == "")
if let city = person?.address?.city, !city.isEmpty {
    assert(city == "Kyiv")
}

// Manual compiler and runtime experiments; do not enable in the normal run:
// let impossible: Bool = missingAccount?.preferences?.notificationsEnabled
//   A Bool? cannot be used as a non-optional Bool.
// let unsafeIndex = grades["Ada"]?[99]
//   A present array still traps for an out-of-bounds index.
// let unsafeUnwrap = personWithoutCity?.address?.city!
//   A forced unwrap can still trap when the value is nil.

print("All Molecule #005 checks passed.")

// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #005
// Optional Chaining: Let Absence Flow Through an Expression
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Explore. Change things. Break things. Learn why.

// MARK: - 1. A chain can stop at any optional link
// WHAT: ?. accesses a member only when the value to its left exists.
// WHY: A missing account, missing preferences, and a stored false are different cases.
// EXPECT: Optional(false), nil, nil. A false value is present, not missing.

struct Preferences { var notificationsEnabled: Bool }
struct Account { var preferences: Preferences? }

let account: Account? = Account(preferences: Preferences(notificationsEnabled: false))
let missingAccount: Account? = nil
let noPreferences: Account? = Account(preferences: nil)

print("Notifications disabled:", account?.preferences?.notificationsEnabled as Any)
print("Missing account:", missingAccount?.preferences?.notificationsEnabled as Any)
print("Missing preferences:", noPreferences?.preferences?.notificationsEnabled as Any)

// TRY: Change false to true, then change account to nil.
// Predict which output becomes Optional(true) and which becomes nil.

// MARK: - 2. Every link can change the result
// WHAT: Chaining can cross several optional properties and continue into a nonoptional member.
// WHY: The final expression is optional even when count itself returns Int.
// EXPECT: Optional("Kyiv"), Optional(4), nil.

struct Address { var city: String? }
struct Person { var address: Address? }

let person: Person? = Person(address: Address(city: "Kyiv"))
let personWithoutCity: Person? = Person(address: Address(city: nil))

print("City:", person?.address?.city as Any)
print("City length:", person?.address?.city?.count as Any)
print("Missing city length:", personWithoutCity?.address?.city?.count as Any)

// TRY: Replace "Kyiv" with "" and compare Optional(0) with nil.

// MARK: - 3. Assignment skips its right-hand side when the chain fails
// WHAT: An optional assignment succeeds only if its receiver exists.
// WHY: Swift does not even evaluate the new value when the receiver is nil.
// EXPECT: First counter 0, then 1; successful assignment stores "Ready".

struct Note { var text: String }
var note: Note? = nil
var textBuilds = 0
func nextText() -> String {
    textBuilds += 1
    return "Ready"
}

note?.text = nextText()
print("Text builds after missing note:", textBuilds)
note = Note(text: "Draft")
note?.text = nextText()
print("Text builds after existing note:", textBuilds)
print("Updated note:", note?.text as Any)

// TRY: Give note an initial value before the first assignment. Predict the counter.

// MARK: - 4. Optional method calls skip argument evaluation too
// WHAT: A method is not called if its optional receiver is nil.
// WHY: This also avoids constructing arguments for a call that cannot happen.
// EXPECT: First counter 0, then 1; the mailbox contains ["Hello"].

struct Mailbox {
    var messages: [String] = []
    mutating func append(_ message: String) { messages.append(message) }
}

var mailbox: Mailbox? = nil
var messageBuilds = 0
func nextMessage() -> String {
    messageBuilds += 1
    return "Hello"
}

mailbox?.append(nextMessage())
print("Message builds with no mailbox:", messageBuilds)
mailbox = Mailbox()
mailbox?.append(nextMessage())
print("Message builds with mailbox:", messageBuilds)
print("Messages:", mailbox?.messages as Any)

// TRY: Initialize mailbox before the first call. How many messages will it contain?

// MARK: - 5. Chaining does not create missing dictionary entries
// WHAT: A dictionary lookup returns an optional value.
// WHY: Chained mutation can change an existing array but cannot invent a missing key.
// EXPECT: Ada has [80, 90, 100]; Leo remains nil.

var grades = ["Ada": [80, 90]]
grades["Ada"]?.append(100)
grades["Leo"]?.append(100)
print("Ada:", grades["Ada"] as Any)
print("Leo:", grades["Leo"] as Any)

// TRY: Add grades["Leo"] = [] before appending and observe the difference.

// MARK: - 6. Chaining and nil coalescing solve different problems
// WHAT: ?? provides a fallback for nil, not for an empty string.
// WHY: A present but empty value may need separate validation.
// EXPECT: "Kyiv", "Unknown", and "" (an empty string).

let cityLabel = person?.address?.city ?? "Unknown"
let unknownCity = personWithoutCity?.address?.city ?? "Unknown"
let emptyCity: Person? = Person(address: Address(city: ""))
print("Known city:", cityLabel)
print("Missing city:", unknownCity)
print("Empty city:", emptyCity?.address?.city ?? "Unknown")

// TRY: Add an if let condition with !city.isEmpty to reject empty names.

// MARK: - 7. What optional chaining does not protect
// WHAT: Optional chaining checks for nil; it does not make every operation safe.
// WHY: An existing array still traps on an invalid index, and ! can still force a trap.
// Uncomment only one example at a time; these are deliberately inactive.

// let wrongType: Bool = missingAccount?.preferences?.notificationsEnabled
// A Bool? cannot be assigned to Bool without unwrapping.
//
// let invalidIndex = grades["Ada"]?[99]
// Ada exists, so an out-of-bounds access still traps.
//
// let forcedCity = personWithoutCity?.address?.city!
// The chain reaches a nil city; forced unwrapping still traps.

// Takeaway: ?. stops a chain on nil. It does not validate present values.
// Final experiment: Change one receiver from nil to a value and trace which
// expressions start executing, including their argument construction.

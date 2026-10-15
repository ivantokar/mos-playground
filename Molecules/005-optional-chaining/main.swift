// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #005
// Optional Chaining: Let Absence Flow Through an Expression
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/optional-chaining-let-absence-flow-through-an-expression
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
//
// A small, executable lesson. Read it from top to bottom, then change the
// values and run it again with: swift run molecule-005
//
// Optional chaining uses ? to continue through an optional value.
// If a link is nil, Swift stops at that link and the result is nil.

func section(_ title: String) {
    print("\n--- \(title) ---")
}

// MARK: 1. Read an optional property
//
// Imagine a profile screen. The user may have no nickname.
// We can read it with ?. and choose a fallback with ??.

struct Profile {
    let name: String
    let nickname: String?
}

let profile: Profile? = Profile(name: "Alex", nickname: nil)

section("1. Reading a profile")
print(profile?.name ?? "Guest")               // Alex
print(profile?.nickname ?? "No nickname")    // No nickname

// Try it: change nickname to "Lex". What does the second line print?
// Try it: set profile to nil. What happens to both lines?

// MARK: 2. Follow more than one optional link
//
// A user may have no address, and an address may have no city.
// Each ? marks a place where the chain can stop.

struct Address {
    let city: String?
}

struct User {
    let address: Address?
}

let user: User? = User(address: Address(city: "Kyiv"))

section("2. Reading a nested value")
let city: String? = user?.address?.city
print(city ?? "Unknown city") // Kyiv

// The result is String?, even though there are several ? marks.
// Try it: change address to nil, then change city to nil.
// Both cases print "Unknown city", but the missing link is different.

// MARK: 3. Optional chaining versus optional binding
//
// Use chaining when you just want the value or a fallback.
// Use if let when you need to work with a confirmed value.

section("3. Using the value")
if let city = user?.address?.city {
    print("City name has \(city.count) characters") // 4
} else {
    print("City is missing")
}

// Try it: use an empty string for city. Is an empty city the same as nil?
// Hint: optional chaining checks for nil; it does not validate text.

// MARK: 4. A useful dictionary pattern
//
// Dictionary lookups return optionals because a key may be missing.
// Chaining lets us modify an existing array without creating a new key.

section("4. Updating existing data")
var scores = ["Alex": [10, 20]]
scores["Alex"]?.append(30)
scores["Sam"]?.append(30)

print(scores["Alex"] ?? []) // [10, 20, 30]
print(scores["Sam"] as Any) // nil

// Try it: add scores["Sam"] = [] before the append.
// What changes? The missing key now has a real array.

// MARK: 5. Under the Hood — skipped work
//
// This is an advanced detail, not something you need for every chain.
// If the optional target is nil, an optional assignment does not
// evaluate the value on the right-hand side.

struct Draft {
    var title: String
}

var draft: Draft? = nil

func makeTitle() -> String {
    print("Making a title...")
    return "Hello Swift"
}

section("5. Skipping an assignment")
draft?.title = makeTitle()
print(draft?.title ?? "No draft") // No draft
// No "Making a title..." line appears: makeTitle() did not run.

draft = Draft(title: "Untitled")
draft?.title = makeTitle()
// Now makeTitle() runs because draft contains a value.
print(draft?.title ?? "No draft") // Hello Swift

// Try it: comment out the second assignment to draft.
// Optional chaining is not a general safety shield: it does not
// validate array indices or protect a forced unwrap from trapping.

print("\nLesson complete. Change one value and run it again!")

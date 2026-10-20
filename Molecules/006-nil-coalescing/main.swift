// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #006
// Nil Coalescing: Provide Defaults Without Branching
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/nil-coalescing-provide-defaults-without-branching
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Explore. Change things. Break things. Learn why.
//
// Run: swift run molecule-006
// Every section prints a result you can compare after making the suggested edit.

// MARK: - 1. A missing value, not a false or empty value

// WHAT: ?? uses the value inside an optional when it exists, otherwise a fallback.
// WHY: A setting that is false or empty is still present; it is not nil.
let missingName: String? = nil
let savedName: String? = "Mira"
print("missing name:", missingName ?? "Guest")
print("saved name:", savedName ?? "Guest")

let disabled: Bool? = false
let emptyLabel: String? = ""
print("disabled flag:", disabled ?? true)
print("empty label stays empty:", String(reflecting: emptyLabel ?? "Untitled"))
// EXPECT: Guest, Mira, false, and an empty string (printed as "").
// TRY: Make disabled nil: the result changes from false to true.
// TRY: Replace emptyLabel with nil: the result becomes "Untitled".

// MARK: - 2. The fallback is not evaluated unless it is needed

// WHAT: ?? evaluates its fallback only when the optional is nil.
// WHY: A fallback might be expensive or have visible side effects.
var fallbackCalls = 0
@MainActor func buildFallback() -> String {
    fallbackCalls += 1
    print("building fallback", fallbackCalls)
    return "Generated"
}

let cached: String? = "Cached"
print("first choice:", cached ?? buildFallback())
print("calls after first choice:", fallbackCalls)
let unavailable: String? = nil
print("second choice:", unavailable ?? buildFallback())
print("calls after second choice:", fallbackCalls)
// EXPECT: The first choice is Cached; no fallback is built. The second builds once.
// TRY: Set cached to nil and compare when "building fallback" appears.

// MARK: - 3. Compose a chain with a default

// WHAT: Optional chaining reads along a possibly missing path; ?? supplies
// one final value when that read returns nil.
struct Preferences { let language: String? }
struct Account { let preferences: Preferences? }
let account: Account? = Account(preferences: Preferences(language: "uk"))
let missingAccount: Account? = nil
print("account language:", account?.preferences?.language ?? "en")
print("missing account language:", missingAccount?.preferences?.language ?? "en")
// EXPECT: uk, then en. The type of each printed expression is String, not String?.
// TRY: Change language to nil while leaving the account present.

// MARK: - 4. Fallback reads do not insert dictionary keys

// WHAT: A missing dictionary key returns nil, so ?? can provide a read-only zero.
// WHY: Reading a default and storing a default are different operations.
var visits = ["Mira": 3]
print("missing count:", visits["Noah"] ?? 0)
print("has Noah after read:", visits["Noah"] != nil)
visits["Noah", default: 0] += 1
print("count after update:", visits["Noah"] ?? 0)
// EXPECT: 0, false, then 1. Only the defaulted subscript inserts Noah.
// TRY: Remove the update line: reading the missing key never creates it.

// MARK: - 5. A fallback is not validation

// WHAT: ?? distinguishes nil from a value; it does not explain why nil arose.
// WHY: Using zero for failed input can hide an error from the caller.
let rawInput = "many"
let parsed = Int(rawInput)
print("number with fallback:", parsed ?? 0)
if let parsed {
    print("validated number:", parsed)
} else {
    print("invalid number: ask for a new input")
}
// EXPECT: 0 from the fallback, then an explicit invalid-input explanation.
// TRY: Use "0" instead of "many". The first line is still 0, but the branch succeeds.

// MARK: - 6. Several fallbacks and a present empty collection

// WHAT: Coalescing can choose the first available optional in a chain.
let preferred: String? = nil
let secondary: String? = "Backup"
print("selected server:", preferred ?? secondary ?? "Offline")
let storedItems: [String]? = []
print("stored item count:", (storedItems ?? ["Starter"]).count)
// EXPECT: Backup and 0. An empty array exists, so no starter is supplied.
// TRY: Set secondary to nil and storedItems to nil; the outputs become Offline and 1.

// The model to remember: ?? answers "was there a value?", not "was it useful?".

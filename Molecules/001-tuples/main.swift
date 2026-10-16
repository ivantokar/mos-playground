// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #001
// Tuples: Group Values Without Creating a Type
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/tuples-group-values-without-creating-a-type
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Explore. Change things. Break things. Learn why.

// MARK: - 1. Group values without declaring a new nominal type
// WHAT: Explore group values without declaring a new nominal type using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: A tuple keeps these two response fields together without requiring a dedicated type.
// TRY: Change status to 404 and message to "Not Found"; check that named access still works.

// A tuple is useful when the relationship is local and the group itself does not
// need behavior or a reusable identity.
let response = (status: 200, message: "OK")
print(response.status, response.message)

// MARK: - 2. The tuple type can be explicit
// WHAT: Explore the tuple type can be explicit using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: The annotation specifies both element types and labels; the literal gets its labels from that context.
// TRY: Change (3, 9) to (min: -3, max: 9). Then try a String where an Int is required.

// Labels are part of the tuple type, while an unlabeled tuple literal can still
// be assigned when contextual labels are known.
let bounds: (min: Int, max: Int) = (3, 9)
print(bounds.min, bounds.max)

// MARK: - 3. Return several related values as one compound value
// WHAT: Explore return several related values as one compound value using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: The optional return covers an empty array: there is no first value from which to calculate extremes.
// TRY: Call extremes(in: []) and print a fallback in an else branch.

func extremes(in values: [Int]) -> (min: Int, max: Int)? {
    guard let first = values.first else { return nil }

    var minValue = first
    var maxValue = first

    for value in values.dropFirst() {
        minValue = min(minValue, value)
        maxValue = max(maxValue, value)
    }

    return (minValue, maxValue)
}

if let result = extremes(in: [8, -6, 2, 109, 3, 71]) {
    print(result.min, result.max)
}

// MARK: - 4. Destructuring can ignore values you do not need
// WHAT: Explore destructuring can ignore values you do not need using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: The underscore ignores the name field; id and isAdmin remain bound to their tuple positions.
// TRY: Replace _ with name and include it in the print statement.

let user = (id: 42, name: "Mira", isAdmin: true)
let (id, _, isAdmin) = user
print(id, isAdmin)

// MARK: - 5. Optional tuple vs tuple of optionals
// WHAT: Explore optional tuple vs tuple of optionals using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: An optional tuple can be entirely absent, while a tuple of optionals can exist with only one coordinate.
// TRY: Give maybePoint a value, then set both coordinates of partialPoint to nil.

let maybePoint: (x: Int, y: Int)? = nil
let partialPoint: (x: Int?, y: Int?) = (x: 10, y: nil)
print(maybePoint as Any)
print(partialPoint as Any)

// MARK: - 6. Tuples compose with switch pattern matching
// WHAT: Explore tuples compose with switch pattern matching using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: A switch checks cases in order; a wildcard matches any value at that position.
// TRY: Change point to (0, 0), then (3, 0), and predict the chosen case.

let point = (x: 0, y: 4)

switch point {
case (0, 0): print("origin")
case (0, _): print("y-axis")
case (_, 0): print("x-axis")
default: print("elsewhere")
}

// MARK: - 7. Direct equality does not imply protocol conformance
// WHAT: Explore direct equality does not imply protocol conformance using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: Equality between supported tuple elements does not mean the tuple conforms to Equatable or Hashable as a generic type.
// TRY: Try each commented compiler experiment separately and read the diagnostic.

print((1, 2) == (1, 2))

// Manual compiler experiments:
//
// Uncomment to observe that a tuple cannot satisfy a generic Equatable
// requirement in the currently verified toolchains.
//
// func requiresEquatable<T: Equatable>(_ value: T) {}
// requiresEquatable((1, 2))
//
// Uncomment to observe the Hashable requirement of Dictionary.Key.
//
// let lookup: [(Int, Int): String] = [(1, 2): "value"]

// MARK: - 8. Know when the tuple has grown into a real type
// WHAT: Explore know when the tuple has grown into a real type using a runnable Swift example.
// EXPECT: Read the printed values below and compare them with the WHY explanation; then change the input in TRY.
// WHY: Use a named struct when coordinates need protocol conformance or reusable behavior.
// TRY: Create a Set<Coordinate> and test whether it contains coordinate.

struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

let coordinate = Coordinate(x: 2, y: 5)
print(coordinate)

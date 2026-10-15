// -----------------------------------------------------------------------------
// MOLECULES OF SWIFT · #001
// Tuples: Group Values Without Creating a Type
//
// Ivan Tokar · https://ivantokar.com
// Article: https://ivantokar.com/posts/tuples-group-values-without-creating-a-type
// Playground: https://github.com/ivantokar/mos-playground
// -----------------------------------------------------------------------------
//
// Read each step, run the program, then try the suggested changes.
// Tuples group a few related values without declaring a new struct.

print("1. A small result")
let response = (status: 200, message: "OK")
print(response.status)  // 200
print(response.message) // OK
// WHY: names make each position easier to understand than .0 and .1.
// TRY: add a third field, such as elapsedMilliseconds: 42.

print("\n2. Return two answers")
func extremes(_ numbers: [Int]) -> (min: Int, max: Int)? {
    guard let first = numbers.first else { return nil }
    var low = first
    var high = first
    for number in numbers.dropFirst() {
        low = min(low, number)
        high = max(high, number)
    }
    return (low, high)
}
if let result = extremes([8, -6, 2, 109]) {
    print("From \(result.min) to \(result.max)") // From -6 to 109
}
// WHY: the two values belong to one small result. The optional means
// an empty collection has no minimum or maximum.
// TRY: pass [] and add an else branch to explain the missing result.

print("\n3. Take only what you need")
let user = (id: 42, name: "Mira", isAdmin: true)
let (id, _, isAdmin) = user
print("User \(id), admin: \(isAdmin)") // User 42, admin: true
// WHY: _ discards the name when this part of the program does not need it.
// TRY: bind name instead of _ and print it.

print("\n4. Two different optional shapes")
let missingPoint: (x: Int, y: Int)? = nil
let incompletePoint: (x: Int?, y: Int?) = (x: 10, y: nil)
print(missingPoint as Any)    // nil
print(incompletePoint as Any) // a tuple with x present and y missing
// WHY: the first optional covers the whole pair; the second has two
// independently optional coordinates.

print("\n5. When to use a struct instead")
struct Coordinate: Hashable {
    let x: Int
    let y: Int
}
let visited: Set<Coordinate> = [Coordinate(x: 2, y: 5)]
print(visited.contains(Coordinate(x: 2, y: 5))) // true
// WHY: a named type can conform to protocols and grow reusable behavior.
// TRY: add a computed property describing the coordinate.

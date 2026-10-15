// Molecules of Swift #002 — Tuple Patterns
// A tuple groups values. A tuple pattern takes them apart at the point of use.

print("1. Give the parts names")
let response = (status: 200, message: "OK")
let (status, message) = response
print("\(status): \(message)") // 200: OK
// WHY: the pattern matches the tuple's two positions.
// TRY: swap the variable names. Does Swift swap the values too?

print("\n2. Ignore a value")
let account = (id: 42, name: "Mira", isAdmin: true)
let (id, _, isAdmin) = account
print("\(id) is admin: \(isAdmin)") // 42 is admin: true
// WHY: _ means this position is not needed here.

print("\n3. Unpack inside a loop")
let scores = [("Mira", 91), ("Noah", 84), ("Ava", 97)]
for (name, score) in scores {
    print("\(name): \(score)")
}
// WHY: there is no need to access .0 and .1 for every row.
// TRY: print only scores >= 90.

print("\n4. Match a point")
let point = (x: 0, y: 4)
switch point {
case (0, 0): print("Origin")
case (0, _): print("On the y-axis") // this branch
case (_, 0): print("On the x-axis")
default: print("Elsewhere")
}
// WHY: patterns describe shapes; _ accepts any value in that position.
// TRY: change point to (0, 0). Why must the origin case come first?

print("\n5. Add a condition")
let vector = (x: 3, y: -3)
switch vector {
case let (x, y) where x == y: print("Main diagonal")
case let (x, y) where x == -y: print("Other diagonal") // this branch
default: print("Not on either diagonal")
}
// WHY: where adds a rule after the values have been bound.
// TRY: change y to 3, then 4. Predict the branch each time.

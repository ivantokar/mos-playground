import Foundation
// Molecules of Swift #003 — guard
// guard checks a requirement and exits early when it fails.
// This leaves the successful path easy to follow.

print("1. Require a value")
func greet(_ name: String?) {
    guard let name else {
        print("No name supplied")
        return
    }
    print("Hello, \(name)")
}
greet("Mira") // Hello, Mira
greet(nil)    // No name supplied
// WHY: after guard, name is a non-optional String.
// TRY: remove return from else. Read the compiler's error.

print("\n2. Validate in small steps")
func username(_ input: String?) -> String? {
    guard let input else { return nil }
    let cleaned = input.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !cleaned.isEmpty else { return nil }
    return cleaned.lowercased()
}
print(username("  MIRA  ") ?? "Invalid") // mira
print(username("   ") ?? "Invalid")     // Invalid
// WHY: missing text and blank text are different checks.
// TRY: remove the second guard and observe what an empty input returns.

print("\n3. Check several requirements")
func endpoint(host: String?, port: Int?) -> String? {
    guard let host, !host.isEmpty,
          let port, (1...65_535).contains(port) else {
        return nil
    }
    return "\(host):\(port)"
}
print(endpoint(host: "localhost", port: 8080) ?? "Invalid") // localhost:8080
print(endpoint(host: "", port: 8080) ?? "Invalid")          // Invalid
// WHY: every requirement must pass before the final return.
// TRY: use port 70_000 and explain the result.

print("\n4. Skip a loop item")
for name in ["Mira", "", "Noah"] {
    guard !name.isEmpty else { continue }
    print("Valid: \(name)") // Mira, then Noah
}
// WHY: inside a loop, continue leaves this iteration, not the function.
// TRY: replace continue with break. What happens to Noah?

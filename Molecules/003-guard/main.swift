import Foundation

print("Molecule #003 — guard: Keep the Main Path Flat")

// MARK: - 1. Validate and normalize input
// WHY: guard let returns early for nil, so the rest of the function works with a String.
// TRY: Try "  ADA  ", an empty string, and nil. Compare missing and blank input.

func normalizedUsername(_ input: String?) -> String? {
    guard let input else {
        print("Missing username")
        return nil
    }

    let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else {
        print("Empty username")
        return nil
    }

    return trimmed.lowercased()
}

print(normalizedUsername("  Mira  ") ?? "nil")
print(normalizedUsername("   ") ?? "nil")
print(normalizedUsername(nil) ?? "nil")

// MARK: - 2. Read a dictionary value
// WHY: Dictionary lookup returns an optional; guard handles a missing key before formatting the name.
// TRY: Change the dictionary key from name to nickname and predict the fallback.

func displayName(from profile: [String: String]) -> String {
    guard let name = profile["name"] else {
        return "Anonymous"
    }
    return "User: \(name)"
}

print(displayName(from: ["name": "Noah"]))
print(displayName(from: [:]))

// MARK: - 3. Check multiple requirements
// WHY: Each comma-separated condition must succeed before the endpoint is built.
// TRY: Try port 0, port 65_535, and a missing host.

func endpoint(host: String?, port: Int?) -> String? {
    guard
        let host,
        !host.isEmpty,
        let port,
        (1...65_535).contains(port)
    else {
        return nil
    }
    return "\(host):\(port)"
}

print(endpoint(host: "localhost", port: 8080) ?? "invalid")
print(endpoint(host: "", port: 8080) ?? "invalid")
print(endpoint(host: "localhost", port: 70_000) ?? "invalid")

// MARK: - 4. Skip invalid loop entries
// WHY: continue skips only the current iteration, leaving later names to be processed.
// TRY: Replace continue with break and see which names are printed.

let rawNames: [String?] = ["Mira", nil, "", "Noah"]
for rawName in rawNames {
    guard let rawName, !rawName.isEmpty else {
        continue
    }
    print("valid name: \(rawName)")
}

// MARK: - 5. Compiler experiments
// WHY: A failing guard must leave its enclosing scope, while if-let bindings stay inside their branch.
// TRY: Remove return in the commented guard experiment and inspect the diagnostic.

// Manual compiler experiment: remove the return to see guard enforce exit.
// func invalidGuard(_ value: Int) {
//     guard value > 0 else {
//         print("Not positive")
//         return
//     }
//     print(value)
// }

// Compare scope with if-let by uncommenting the final print.
// func ifBinding(_ value: String?) {
//     if let value { print(value) }
//     print(value) // Error: cannot find value in scope
// }

// Learning exercise: choose one example above, change a single input,
// predict the result, and run the executable to compare.

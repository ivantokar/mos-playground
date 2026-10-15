import Foundation

print("Molecule #003 — guard: Keep the Main Path Flat")

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

func displayName(from profile: [String: String]) -> String {
    guard let name = profile["name"] else {
        return "Anonymous"
    }
    return "User: \(name)"
}

print(displayName(from: ["name": "Noah"]))
print(displayName(from: [:]))

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

let rawNames: [String?] = ["Mira", nil, "", "Noah"]
for rawName in rawNames {
    guard let rawName, !rawName.isEmpty else {
        continue
    }
    print("valid name: \(rawName)")
}

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

// -----------------------------------------------------------------------------
// GUIDED EXERCISES — read the examples above before trying these changes.
// The original examples and MARK sections above are intentionally preserved.
// 1. Predict the output of each print before running this executable.
// 2. Change one input at a time and compare the output with your prediction.
// 3. Uncomment one manual compiler experiment at a time (if provided),
//    read the diagnostic, and comment it out again before running normally.
// 4. Explain in your own words which Swift rule each example demonstrates.
// -----------------------------------------------------------------------------

extension String {
    var nonArray: String {
        if hasPrefix("[") {
            return String(dropFirst().dropLast())
        } else if hasPrefix("Array<") {
            return String(replacingOccurrences(of: "Array<", with: "").dropLast())
        } else if hasPrefix("ArrayK<") {
            return String(replacingOccurrences(of: "ArrayK<", with: "").dropLast())
        } else if hasPrefix("NEA<") {
            return String(replacingOccurrences(of: "NEA<", with: "").dropLast())
        } else if hasPrefix("NonEmptyArray<") {
            return String(replacingOccurrences(of: "NonEmptyArray<", with: "").dropLast())
        } else {
            return self
        }
    }
}

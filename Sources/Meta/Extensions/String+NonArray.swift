extension String {
    var nonArray: String {
        substring(pattern: "(?<=\\[).*(?=\\])")
            .substring(pattern: "(?<=ArrayK<).*(?=>)")
            .substring(pattern: "(?<=Array<).*(?=>)")
            .substring(pattern: "(?<=NEA<).*(?=>)")
            .substring(pattern: "(?<=NonEmptyArray<).*(?=>)")
            .trimmingCharacters
    }
    
    var isArrayType: Bool {
        contains("[") ||
        contains("Array<") ||
        contains("ArrayK<") ||
        contains("NEA<") ||
        contains("NonEmptyArray<")
    }
}

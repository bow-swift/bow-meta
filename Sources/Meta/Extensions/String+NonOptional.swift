extension String {
    var nonOptional: String {
        substring(pattern: "(?<=Optional<).*(?=>)")
            .substring(pattern: "(?<=Option<).*(?=>)")
            .clean("?")
            .trimmingCharacters
    }
    
    var isOptionalType: Bool {
        contains("?") ||
        contains("Optional<") ||
        contains("Option<")
    }
}

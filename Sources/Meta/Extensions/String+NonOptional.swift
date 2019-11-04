extension String {
    var nonOptional: String {
        let trimmed = self.trimmingCharacters
        
        if trimmed.ends(with: "?") { return String(trimmed.dropLast()) }
        else if trimmed.starts(with: "Optional<"), trimmed.ends(with: ">") { return String(trimmed.dropFirst("Optional<".count).dropLast()) }
        else if trimmed.starts(with: "Option<"), trimmed.ends(with: ">")   { return String(trimmed.dropFirst("Option<".count).dropLast()) }
        
        return trimmed
    }
    
    var isOptionalType: Bool {
        trimmingCharacters != nonOptional
    }
}

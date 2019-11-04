extension String {
    var nonArray: String {
        let trimmed = self.trimmingCharacters
        
        if trimmed.starts(with: "["), trimmed.ends(with: "]") { return String(trimmed.dropFirst().dropLast()) }
        else if trimmed.starts(with: "ArrayK<"), trimmed.ends(with: ">") { return String(trimmed.dropFirst("ArrayK<".count).dropLast()) }
        else if trimmed.starts(with: "Array<"), trimmed.ends(with: ">")  { return String(trimmed.dropFirst("Array<".count).dropLast()) }
        else if trimmed.starts(with: "NEA<"), trimmed.ends(with: ">")    { return String(trimmed.dropFirst("NEA<".count).dropLast()) }
        else if trimmed.starts(with: "NonEmptyArray<"), trimmed.ends(with: ">") { return String(trimmed.dropFirst("NonEmptyArray<".count).dropLast()) }
        
        return trimmed
    }
    
    var isArrayType: Bool {
        trimmingCharacters != nonArray
    }
}

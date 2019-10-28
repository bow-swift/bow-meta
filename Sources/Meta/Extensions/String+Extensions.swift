extension String {
    
    var firstLowercased: String {
        (first?.lowercased() ?? "") + dropFirst()
    }
    
    var firstUppercased: String {
        (first?.uppercased() ?? "") + dropFirst()
    }
}

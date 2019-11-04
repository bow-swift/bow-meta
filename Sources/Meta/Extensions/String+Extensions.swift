import Foundation

extension String {
    
    var firstLowercased: String {
        (first?.lowercased() ?? "") + dropFirst()
    }
    
    var firstUppercased: String {
        (first?.uppercased() ?? "") + dropFirst()
    }
    
    var trimmingCharacters: String {
        trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func ends(with possibleSuffix: String) -> Bool {
        reversed().starts(with: possibleSuffix.reversed())
    }
}

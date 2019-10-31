import Foundation

extension String {
    
    var firstLowercased: String {
        (first?.lowercased() ?? "") + dropFirst()
    }
    
    var firstUppercased: String {
        (first?.uppercased() ?? "") + dropFirst()
    }
    
    func clean(_ ocurrences: String...) -> String {
        return ocurrences.reduce(self) { (output, ocurrence) in
            output.replacingOccurrences(of: ocurrence, with: "")
        }
    }
    
    func substring(pattern: String) -> String {
        let range = NSRange(location: 0, length: self.count)
        guard let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive),
              let match = regex.firstMatch(in: self, options: [], range: range) else { return self }

        return NSString(string: self).substring(with: match.range) as String
    }
}

import SwiftSyntax

public enum SyntaxModifier: String, CustomStringConvertible, CaseIterable, Equatable, Hashable {
    case `private`
    case `internal`
    case `public`
    case `open`
    
    public var description: String { rawValue }
    public var preference: Int {
        switch self {
        case .private:  return 2
        case .internal: return 1
        case .public:   return 0
        case .open:     return -1
        }
    }
}


extension Array where Element == SyntaxModifier {
    var modifier: SyntaxModifier {
        guard self.count > 0 else { return .internal }
        return sorted { v1, v2 in v1.preference > v2.preference }.first!
    }
}

extension SwiftSyntax.Syntax {
    var modifiers: Set<SyntaxModifier> {
        Set((description as String).trimmingCharacters(in: .whitespacesAndNewlines)
                                   .components(separatedBy: " ")
                                   .compactMap(SyntaxModifier.init))
    }
}

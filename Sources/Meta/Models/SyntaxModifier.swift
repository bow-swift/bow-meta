import SwiftSyntax

public enum SyntaxModifier: String, CustomStringConvertible, CaseIterable, Equatable, Hashable {
    case `private`
    case `internal`
    case `public`
    case `open`
    
    public var description: String { rawValue }
}

fileprivate extension SyntaxModifier {
    var precedence: Int {
        switch self {
        case .private:  return 3
        case .internal: return 2
        case .public:   return 1
        case .open:     return 0
        }
    }
}

extension Array where Element == SyntaxModifier {
    var modifier: SyntaxModifier {
        guard self.count > 0 else { return .internal }
        return sorted { v1, v2 in v1.precedence > v2.precedence }.first!
    }
}

extension SwiftSyntax.Syntax {
    var modifiers: Set<SyntaxModifier> {
        Set((description as String).trimmingCharacters(in: .whitespacesAndNewlines)
                                   .components(separatedBy: " ")
                                   .compactMap(SyntaxModifier.init))
    }
}

import SwiftSyntax

public enum VisibilityModifier: String, CustomStringConvertible, CaseIterable, Equatable, Hashable {
    case `private`
    case `internal`
    case `public`
    case `open`
    
    public var description: String { rawValue }
}

fileprivate extension VisibilityModifier {
    var precedence: Int {
        switch self {
        case .private:  return 3
        case .internal: return 2
        case .public:   return 1
        case .open:     return 0
        }
    }
}

extension Array where Element == VisibilityModifier {
    var modifier: VisibilityModifier {
        guard self.count > 0 else { return .internal }
        return sorted { v1, v2 in v1.precedence > v2.precedence }.first!
    }
}

extension SwiftSyntax.Syntax {
    var modifiers: Set<VisibilityModifier> {
        Set(description.trimmingCharacters(in: .whitespacesAndNewlines)
                       .components(separatedBy: " ")
                       .compactMap(VisibilityModifier.init))
    }
}

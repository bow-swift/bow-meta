import Foundation
import Bow

// MARK: Instance of `Semigroup` for `Set`
extension Set: Semigroup {
    public func combine(_ other: Set<Element>) -> Set<Element> {
        return self.union(other)
    }
}

// MARK: Instance of `Monoid` for `Set`
extension Set: Monoid {
    public static func empty() -> Set<Element> {
        return Set()
    }
}

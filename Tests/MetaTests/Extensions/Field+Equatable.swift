import Foundation
import Meta

func ==(lhs: Field, rhs: Field) -> Bool {
    lhs.name == rhs.name &&
    lhs.type == rhs.type
}

func ==(lhs: [Field], rhs: [Field]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    return zip(lhs, rhs).map { l, r in l == r }.reduce(true) { x, y in x && y }
}

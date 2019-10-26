import Foundation
import Meta

func ==(lhs: Case, rhs: Case) -> Bool {
    lhs.associatedValues == rhs.associatedValues && lhs.name == rhs.name
}

func ==(lhs: [Case], rhs: [Case]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    return zip(lhs, rhs).map { l, r in l == r }.reduce(true) { x, y in x && y }
}

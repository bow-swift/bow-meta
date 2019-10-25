import Foundation
import Meta

func ==(lhs: Case, rhs: Case) -> Bool {
    let lhsAssociatedValues = lhs.associatedValues
    let rhsAssociatedValues = rhs.associatedValues
    let equalsAssociatedValues = lhsAssociatedValues.flatMap { l in rhsAssociatedValues.flatMap { r in l == r }} ?? (lhsAssociatedValues == nil && rhsAssociatedValues == nil)
    
    return equalsAssociatedValues && lhs.name == rhs.name
}

func ==(lhs: [Case], rhs: [Case]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    return zip(lhs, rhs).map { l, r in l == r }.reduce(true) { x, y in x && y }
}

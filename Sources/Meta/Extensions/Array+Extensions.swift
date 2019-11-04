import Foundation

extension Array where Element: Hashable {
    var uniques: [Element] {
        NSOrderedSet(array: self).array as! [Element]
    }
}

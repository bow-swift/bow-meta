import XCTest
import Meta
import SnapshotTesting

class TraversalVisitorTests: XCTestCase {
    func testGeneratedTraversal() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .traversal)
    }
    
    func testGeneratedTraversalWithNestedElements() {
        assertSnapshot(matching: URL.meta.fixtures.file(.author), as: .traversal)
    }
    
    func testGeneratedTraversalForBowArrayKandNEA() {
        assertSnapshot(matching: URL.meta.fixtures.file(.company), as: .traversal)
    }
}

import XCTest
import Meta
import SnapshotTesting

class FoldVisitorTests: XCTestCase {
    func testGeneratedFold() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .fold)
    }
    
    func testGeneratedFoldForBowArrayKandNEA() {
        assertSnapshot(matching: URL.meta.fixtures.file(.company), as: .fold)
    }
}

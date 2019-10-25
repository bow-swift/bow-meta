import XCTest
import Meta
import SnapshotTesting

class PrismVisitorTests: XCTestCase {
    
    func testGeneratedPrism() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .prism)
    }
}

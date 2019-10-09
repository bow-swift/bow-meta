import XCTest
import Meta
import SnapshotTesting

class LensVisitorTests: XCTestCase {
    func testGeneratedLens() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .lens)
    }
}

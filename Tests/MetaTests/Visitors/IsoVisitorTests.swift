import XCTest
import Meta
import SnapshotTesting

class IsoVisitorTests: XCTestCase {
    func testGeneratedIso() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .iso)
    }
}

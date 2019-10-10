import XCTest
import Meta
import SnapshotTesting

class OptionalVisitorTests: XCTestCase {
    func testGeneratedOptional() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .optional)
    }
    
    func testGeneratedOptionalForBowOption() {
        assertSnapshot(matching: URL.meta.fixtures.file(.company), as: .optional)
    }
}

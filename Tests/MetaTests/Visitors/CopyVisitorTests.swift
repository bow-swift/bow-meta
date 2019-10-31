import XCTest
import Meta
import SnapshotTesting

class CopyVisitorTests: XCTestCase {
    func testGeneratedCopyMethod() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .copyMethod)
    }
    
    func testGeneratedCopyMethodForNestedStructs() {
        assertSnapshot(matching: URL.meta.fixtures.file(.author), as: .copyMethod)
    }
}

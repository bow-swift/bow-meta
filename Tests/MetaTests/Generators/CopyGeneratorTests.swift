import XCTest
import SnapshotTesting
import Meta

class CopyGeneratorTests: XCTestCase {
    func testCopyGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: CopyGenerator()))
    }
}

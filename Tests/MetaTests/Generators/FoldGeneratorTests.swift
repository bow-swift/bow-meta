import XCTest
import SnapshotTesting
import Meta

class FoldGeneratorTests: XCTestCase {
    func testFoldGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: FoldGenerator()))
    }
}

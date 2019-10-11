import XCTest
import SnapshotTesting
import Meta

class TraversalGeneratorTests: XCTestCase {
    func testTraversalGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: TraversalGenerator()))
    }
}

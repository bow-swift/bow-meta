import XCTest
import SnapshotTesting
import Meta

class OptionalGeneratorTests: XCTestCase {
    func testOptionalGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: OptionalGenerator()))
    }
}

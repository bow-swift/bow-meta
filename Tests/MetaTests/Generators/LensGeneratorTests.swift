import XCTest
import SnapshotTesting
import Meta

class LensGeneratorTests: XCTestCase {
    func testLensGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: LensGenerator()))
    }
}

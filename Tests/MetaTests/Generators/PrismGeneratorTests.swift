import XCTest
import SnapshotTesting
import Meta

class PrismGeneratorTests: XCTestCase {
    
    func testPrismGeneratorMultipleFile() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: PrismGenerator()))
    }
}

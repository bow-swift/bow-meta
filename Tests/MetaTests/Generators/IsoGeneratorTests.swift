import XCTest
import SnapshotTesting
import Meta

class IsoGeneratorTests: XCTestCase {
    func testIsoGeneratorMultipleFiles() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: IsoGenerator()))
    }
}

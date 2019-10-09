import XCTest
import SnapshotTesting
import Meta

class IsoGeneratorTests: XCTestCase {
    func testIsoGeneratorMultipleFiles() {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
        
        assertSnapshot(matching: input, as: .generatedCode(using: IsoGenerator()))
    }
}

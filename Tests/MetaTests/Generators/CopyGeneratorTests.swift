import XCTest
import SnapshotTesting
import Meta

class CopyGeneratorTests: XCTestCase {
    func testGeneratorMultipleFiles() {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
        
        assertSnapshot(matching: input, as: .copyGeneration(for: CopyGenerator()))
    }
}

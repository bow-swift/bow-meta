import XCTest
import SnapshotTesting

class CopyGeneratorTests: XCTestCase {
    func testGeneratorMultipleFiles() {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
        
        assertSnapshot(matching: input, as: .copyGeneration)
    }
}

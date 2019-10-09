import XCTest
import Meta
import SnapshotTesting

class CopyVisitorTests: XCTestCase {
    func testGeneratedCopyMethod() {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
            .appendingPathComponent("Article.swift")
        
        assertSnapshot(matching: input, as: .copyMethod)
    }
}

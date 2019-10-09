import XCTest
import Meta
import SnapshotTesting

class IsoVisitorTests: XCTestCase {
    func testGeneratedIso() {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
            .appendingPathComponent("Article.swift")
        
        assertSnapshot(matching: input, as: .iso)
    }
}

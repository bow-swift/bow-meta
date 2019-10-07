import XCTest
import Meta
import SnapshotTesting
import SwiftSyntax

class CopyVisitorTests: XCTestCase {
    func testGeneratedCopyMethod() throws {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
            .appendingPathComponent("Article.swift")
        
        assertSnapshot(matching: input, as: .copyMethod)
    }
}

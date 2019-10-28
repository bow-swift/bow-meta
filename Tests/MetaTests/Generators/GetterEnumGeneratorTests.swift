import XCTest
import SnapshotTesting
import Meta

class GetterEnumGeneratorTests: XCTestCase {
    func testGetterEnumGeneratorMultipleFile() {
        assertSnapshot(matching: URL.meta.fixtures, as: .generatedCode(using: GetterEnumGenerator()))
    }
}

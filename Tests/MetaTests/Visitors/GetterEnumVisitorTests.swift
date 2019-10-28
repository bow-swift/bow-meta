import XCTest
import Meta
import SnapshotTesting

class GetterEnumVisitorTests: XCTestCase {
    
    func testGeneratedGetterEnum() {
        assertSnapshot(matching: URL.meta.fixtures.file(.article), as: .getterEnum)
    }
}

import XCTest
import Meta
import SwiftSyntax

class ImportVisitorTests: XCTestCase {
    func testFetchesAllImports() throws {
        let visitor = ImportVisitor()
        let ast = try SyntaxTreeParser.parse(URL.currentFile())
        ast.walk(visitor)
        
        let imports = visitor.imports.sorted()
        let expected = ["import Meta", "import SwiftSyntax", "import XCTest"]
        
        XCTAssertEqual(imports, expected)
    }
}

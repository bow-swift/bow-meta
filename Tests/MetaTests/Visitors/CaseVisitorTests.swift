import XCTest
import Meta
import SwiftSyntax

class CaseVisitorTests: XCTestCase {
    func testFetchesAllCases() throws {
        let visitor = CaseVisitor()
        let ast = try SyntaxTreeParser.parse(URL.meta.fixtures.file(.article))
        ast.walk(visitor)
        
        let expected: [Case] = [(name: "draft", nil),
                                (name: "published",  [Field(name: "", type: "Date")]),
                                (name: "deleted",    [Field(name: "", type: "Date"),
                                                      Field(name: "reason", type: "String?")])]
        
        XCTAssertTrue(visitor.cases == expected)
    }
}

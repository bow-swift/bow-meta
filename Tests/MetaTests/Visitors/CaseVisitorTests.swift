import XCTest
import Meta
import SwiftSyntax

class CaseVisitorTests: XCTestCase {
    func testFetchesAllCases() throws {
        let visitor = CaseVisitor()
        let ast = try SyntaxTreeParser.parse(URL.meta.fixtures.file(.article))
        ast.walk(visitor)
        
        let expected: [Case] = [Case(name: "expository",  associatedValues: []),
                                Case(name: "descriptive", associatedValues: []),
                                Case(name: "persuasive",  associatedValues: []),
                                Case(name: "narrative",   associatedValues: []),
                                Case(name: "draft",      associatedValues: [Field(name: "date", type: "Date"), Field(name: "comments", type: "String?")]),
                                Case(name: "published",  associatedValues: [Field(name: "comments", type: "String?"), Field(name: "date", type: "Date")]),
                                Case(name: "deleted",    associatedValues: [Field(name: "date", type: "Date"), Field(name: "reason", type: "String?"), Field(name: "comments", type: "String?")])]
        
        XCTAssertTrue(visitor.cases == expected)
    }
}

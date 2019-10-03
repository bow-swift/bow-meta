import XCTest
import Meta
import SwiftSyntax

class FieldVisitorTests: XCTestCase {
    func testFetchesAllFieldsExceptComputedProperties() throws {
        let input = URL(fileURLWithPath: String(#file))
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("Fixtures")
            .appendingPathComponent("Author.swift")
        let visitor = FieldVisitor()
        
        let ast = try SyntaxTreeParser.parse(input)
        ast.walk(visitor)
        
        let expected = [Field(name: "name", type: "String"),
                        Field(name: "social", type: "[SocialNetwork]")]
        
        XCTAssertTrue(visitor.fields == expected)
    }
}

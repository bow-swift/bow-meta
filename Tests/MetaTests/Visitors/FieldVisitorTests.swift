import XCTest
import Meta
import SwiftSyntax

class FieldVisitorTests: XCTestCase {
    func testFetchesAllFieldsExceptComputedProperties() throws {
        let visitor = FieldVisitor()
        let ast = try SyntaxTreeParser.parse(URL.meta.fixtures.file(.author))
        ast.walk(visitor)
        
        let expected = [Field(name: "name", type: "String"),
                        Field(name: "social", type: "Array<SocialNetwork>")]
        
        XCTAssertTrue(visitor.fields == expected)
    }
}

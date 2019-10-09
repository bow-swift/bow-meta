import SwiftSyntax

public protocol CodegenVisitor: SyntaxVisitor {
    var generatedCode: String { get }
}

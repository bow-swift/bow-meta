import SwiftSyntax

public protocol Codegen: SyntaxVisitor {
    var generatedCode: String { get }
}

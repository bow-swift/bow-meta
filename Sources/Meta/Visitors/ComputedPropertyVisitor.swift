import SwiftSyntax

extension PatternBindingSyntax {
    var isComputed: Bool {
        let visitor = ComputedPropertyVisitor()
        self.walk(visitor)
        return visitor.isComputed
    }
}

private class ComputedPropertyVisitor: SyntaxVisitor {
    var isComputed = false
    override func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
        isComputed = true
        return .skipChildren
    }
}


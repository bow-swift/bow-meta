import SwiftSyntax

extension PatternBindingSyntax {
    var isComputed: Bool {
        let visitor = PropertyVisitor()
        self.walk(visitor)
        return visitor.isComputed
    }
    
    var isExpression: Bool {
        let visitor = PropertyVisitor()
        self.walk(visitor)
        return visitor.isExpression
    }
}

private class PropertyVisitor: SyntaxVisitor {
    var isComputed = false
    var isExpression = false
    
    override func visit(_ node: CodeBlockSyntax) -> SyntaxVisitorContinueKind {
        isComputed = true
        return .skipChildren
    }
    
    override func visit(_ node: InitializerClauseSyntax) -> SyntaxVisitorContinueKind {
        isExpression = true
        return .skipChildren
    }
}


import SwiftSyntax

typealias Member = (name: String, type: String)

extension StructDeclSyntax {
    var members: [Member] {
        let visitor = MemberVisitor()
        self.walk(visitor)
        return visitor.members
    }
}

private class MemberVisitor: SyntaxVisitor {
    var members: [Member] = []
    
    override func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        node.bindings.forEach { binding in
            guard !binding.isComputed,
                let type = binding.typeAnnotation?.type.description else { return }
            
            let name = binding.pattern.description
            members.append((name: name, type: type))
        }
        
        return .skipChildren
    }
    
    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        return .skipChildren
    }
}

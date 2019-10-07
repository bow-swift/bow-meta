import SwiftSyntax

public typealias Field = (name: String, type: String)

public extension StructDeclSyntax {
    var fields: [Field] {
        let visitor = FieldVisitor()
        self.walk(visitor)
        return visitor.fields
    }
}

public class FieldVisitor: SyntaxVisitor {
    public private(set) var fields: [Field] = []
    
    override public func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        node.bindings.forEach { binding in
            guard !binding.isComputed,
                let type = binding.typeAnnotation?.type.description else { return }
            
            let name = binding.pattern.description
            fields.append((name: name, type: type))
        }
        
        return .skipChildren
    }
    
    override public func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        return .skipChildren
    }
}

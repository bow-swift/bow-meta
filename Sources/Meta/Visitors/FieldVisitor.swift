import SwiftSyntax


public struct Field: Equatable, Hashable {
    let name: String
    let type: String
    
    public init(name: String, type: String) {
        self.name = name
        self.type = type
    }
}

public extension StructDeclSyntax {
    var fields: [Field] {
        let visitor = FieldVisitor(self)
        self.walk(visitor)
        return visitor.fields
    }
}

public class FieldVisitor: SyntaxVisitor {
    public private(set) var fields: [Field] = []
    private let node: StructDeclSyntax
    
    public init(_ node: StructDeclSyntax) {
        self.node = node
    }
    
    override public func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        node.bindings.forEach { binding in
            guard !binding.isComputed,
                let type = binding.typeAnnotation?.type.description.trimmingCharacters else { return }
            
            let name = binding.pattern.description.trimmingCharacters
            fields.append(Field(name: name, type: type))
        }
        
        return .skipChildren
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind { .skipChildren }
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        self.node == node ? .visitChildren : .skipChildren
    }
}

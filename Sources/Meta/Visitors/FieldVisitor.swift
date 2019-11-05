import SwiftSyntax

public struct Field: Equatable, Hashable {
    let name: String
    let type: String
    let modifier: VisibilityModifier
    
    public init(name: String, type: String, modifier: VisibilityModifier) {
        self.name = name
        self.type = type
        self.modifier = modifier
    }
}


public extension StructDeclSyntax {
    var fields: [Field] {
        let visitor = FieldVisitor(self)
        self.walk(visitor)
        return visitor.fields
    }
    
    var nonPrivateFields: [Field] {
        fields.filter { field in field.modifier != .private }
    }
}

public class FieldVisitor: SyntaxVisitor {
    public private(set) var fields: [Field] = []
    private let node: StructDeclSyntax
    
    public init(_ node: StructDeclSyntax) {
        self.node = node
    }
    
    override public func visit(_ node: VariableDeclSyntax) -> SyntaxVisitorContinueKind {
        let visibilityModifier = Array(node.modifiers).modifier
        
        node.bindings.forEach { binding in
            guard !binding.isComputed else { return }
            guard let type = binding.typeAnnotation?.type.description.trimmingCharacters else { return }
            let name = binding.pattern.description.trimmingCharacters
            fields.append(Field(name: name,
                                type: type,
                                modifier: visibilityModifier))
        }
        
        return .skipChildren
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind { .skipChildren }
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        self.node == node ? .visitChildren : .skipChildren
    }
}

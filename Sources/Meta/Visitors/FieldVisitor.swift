import SwiftSyntax

public struct Field: Equatable, Hashable {
    let name: String
    let type: String
    let modifier: VisibilityModifier
    let inmutableValue: Bool
    
    public init(name: String, type: String, modifier: VisibilityModifier, inmutableValue: Bool) {
        self.name = name
        self.type = type
        self.modifier = modifier
        self.inmutableValue = inmutableValue
    }
}


public extension StructDeclSyntax {
    var fields: [Field] {
        let visitor = FieldVisitor(self)
        self.walk(visitor)
        return visitor.fields
    }
    
    var accessibleFields: [Field] {
        fields { field in field.modifier != .private && !field.inmutableValue }
    }
    
    func fields(condition: (Field) -> Bool) -> [Field] {
        fields.filter { field in condition(field) }
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
        let isVar = node.letOrVarKeyword.text.trimmingCharacters == "var"
        
        node.bindings.forEach { binding in
            guard !binding.isComputed else { return }
            guard let type = binding.typeAnnotation?.type.description.trimmingCharacters else { return }
            let name = binding.pattern.description.trimmingCharacters
            let inmutableValue = binding.isExpression && !isVar
            
            fields.append(Field(name: name,
                                type: type,
                                modifier: visibilityModifier,
                                inmutableValue: inmutableValue))
        }
        
        return .skipChildren
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind { .skipChildren }
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        self.node == node ? .visitChildren : .skipChildren
    }
}

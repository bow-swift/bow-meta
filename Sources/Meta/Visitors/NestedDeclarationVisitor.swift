import SwiftSyntax

public class NestedDeclarationVisitor: SyntaxVisitor {
    private var nestedDeclaration = NestedDeclaration()
    
    var visitorFullyQualifiedName: String { nestedDeclaration.fullyQualifiedName }
    var visitorModifier: String { nestedDeclaration.modifier }
    
    // MARK: - visitor
    public override func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
        nestedDeclaration.append(node: node)
        return .visitChildren
    }
    
    public override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        nestedDeclaration.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        nestedDeclaration.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        nestedDeclaration.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visitPost(_ node: Syntax) {
        if let node = node as? NodeSyntax { nestedDeclaration.pop(node: node) }
        else if let node = node as? ModifierListSyntax { nestedDeclaration.pop(node: node) }
    }
    
    // MARK: - helpers <visitor>
    private func syntaxVisitorContinueKind(in node: NodeSyntax) -> SyntaxVisitorContinueKind {
        node.hasChildren ? .visitChildren : .skipChildren
    }
}

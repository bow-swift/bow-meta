import SwiftSyntax

public class Visitor: SyntaxVisitor {
    private var branch = Branch()
    
    var visitorFamilyName: String { branch.nodeFamilyName }
    var visitorModifier: String   { branch.nodeModifier }
    
    // MARK: - visitor
    public override func visit(_ node: ModifierListSyntax) -> SyntaxVisitorContinueKind {
        branch.append(node: node)
        return .visitChildren
    }
    
    public override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        branch.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        branch.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        branch.append(node: node)
        return syntaxVisitorContinueKind(in: node)
    }
    
    public override func visitPost(_ node: Syntax) {
        if let node = node as? NodeSyntax { branch.pop(node: node) }
        else if let node = node as? ModifierListSyntax { branch.pop(node: node) }
    }
    
    // MARK: - helpers <visitor>
    private func syntaxVisitorContinueKind(in node: NodeSyntax) -> SyntaxVisitorContinueKind {
        node.hasChildren ? .visitChildren : .skipChildren
    }
}

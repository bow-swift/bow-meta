import SwiftSyntax

public class ImportVisitor: SyntaxVisitor {
    public private(set) var imports: Set<String> = Set()
    
    override public func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.insert(node.description
            .trimmingCharacters(in: .whitespacesAndNewlines))
        return .skipChildren
    }
}

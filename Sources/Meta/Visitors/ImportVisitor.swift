import SwiftSyntax

public class ImportVisitor: SyntaxVisitor {
    public private(set) var imports: Set<ImportDeclSyntax> = Set()
    
    override public func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.insert(node)
        return .skipChildren
    }
}

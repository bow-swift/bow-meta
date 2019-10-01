import SwiftSyntax

class ImportVisitor: SyntaxVisitor {
    private(set) var imports: Set<ImportDeclSyntax> = Set()
    
    override func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        imports.insert(node)
        return .skipChildren
    }
}

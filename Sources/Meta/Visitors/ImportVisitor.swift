import SwiftSyntax

public class ImportVisitor: SyntaxVisitor {
    public private(set) var imports: Set<String> = Set()
    
    override public func visit(_ node: ImportDeclSyntax) -> SyntaxVisitorContinueKind {
        let importToken = node.importTok.text
        let importKind = node.importKind.flatMap { "\($0.text) " } ?? ""
        let importPath = node.path.description
        
        imports.insert("\(importToken) \(importKind)\(importPath)")
        return .skipChildren
    }
}

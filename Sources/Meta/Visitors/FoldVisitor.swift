import SwiftSyntax

public class FoldVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields.filter(isArrayType)
        
        if fields.count > 0 {
            let foldsCode = generateFolds(for: fields, structName: structName)
            
            let code = """
            extension \(structName) {
            \(foldsCode)
            }
            
            """
            print(code, to: &generatedCode)
        }
        
        return .skipChildren
    }
    
    private func isArrayType(_ field: Field) -> Bool { field.type.isArrayType }
    
    private func generateFolds(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateFold(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateFold(_ field: Field, structName: String) -> String {
        """
            static var \(field.name)Fold: Fold<\(structName), \(field.type.nonArray)> {
                \(field.name)Lens + \(field.type).fold
            }
        """
    }
}

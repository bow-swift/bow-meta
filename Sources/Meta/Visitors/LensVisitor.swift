import SwiftSyntax

public class LensVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields
        let lensesCode = generateLenses(for: fields, structName: structName)
        
        let code = """
        extension \(structName) {
        \(lensesCode)
        }
        
        """
        print(code, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func generateLenses(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateLens(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateLens(_ field: Field, structName: String) -> String {
        """
            static var \(field.name)Lens: Lens<\(structName), \(field.type)> {
                Lens(get: { $0.\(field.name) },
                     set: { $0.copy(with\(field.name.firstUppercased): $1) })
            }
        """
    }
}

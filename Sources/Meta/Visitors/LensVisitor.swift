import SwiftSyntax

public class LensVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    public override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = node.accessibleFields
        guard fields.count > 0 else { return visitorContinue }
        
        let code = """
        \(visitorModifier) extension \(visitorFullyQualifiedName) {
        \(generateLenses(for: fields, structName: visitorFullyQualifiedName))
        }
        
        """
        
        print(code, to: &generatedCode)
        
        return visitorContinue
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

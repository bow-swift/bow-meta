import SwiftSyntax

public class TraversalVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let nodeFields = node.nonPrivateFields
        let fields = (nodeFields.arrays + nodeFields.optionalsWithArray).uniques
        guard fields.count > 0 else { return visitorContinue }
        
        let code = """
        \(visitorModifier) extension \(visitorFullyQualifiedName) {
        \(generateTraversals(for: fields, structName: visitorFullyQualifiedName))
        }
        
        """
        
        print(code, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func generateTraversals(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateTraversal(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateTraversal(_ field: Field, structName: String) -> String {
        """
            static var \(field.name)Traversal: Traversal<\(structName), \(field.type.nonOptional.nonArray)> {
                \(field.name)\(field.type.isOptionalType ? "Optional" : "Lens") + \(field.type.nonOptional).traversal
            }
        """
    }
}

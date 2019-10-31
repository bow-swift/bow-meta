import SwiftSyntax

public class TraversalVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = node.fields.arraysType
        guard fields.count > 0 else { return visitorContinue }
        
        let code = """
        extension \(visitorFullyQualifiedName) {
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
            static var \(field.name)Traversal: Traversal<\(structName), \(field.type.nonArray)> {
                \(field.name)Lens + \(field.type).traversal
            }
        """
    }
}

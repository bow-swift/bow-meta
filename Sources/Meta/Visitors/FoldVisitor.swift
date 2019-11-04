import SwiftSyntax

public class FoldVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = (node.fields.arrays + node.fields.optionalsWithArray).uniques
        let structName = visitorFullyQualifiedName
        guard fields.count > 0 else { return visitorContinue }
        
        let code = """
        \(visitorModifier) extension \(structName) {
        \(generateFolds(for: fields, structName: structName))
        }
        
        """
        
        print(code, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func generateFolds(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateFold(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateFold(_ field: Field, structName: String) -> String {
        """
            static var \(field.name)Fold: Fold<\(structName), \(field.type.nonOptional.nonArray)> {
                \(field.name)\(field.type.isOptionalType ? "Optional" : "Lens") + \(field.type.nonOptional).fold
            }
        """
    }
}

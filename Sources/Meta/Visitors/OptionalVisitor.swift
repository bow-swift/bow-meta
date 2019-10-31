import SwiftSyntax

public class OptionalVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = node.fields.filter(isOptionalType)
        guard fields.count > 0 else { return visitorContinue }
        
        let code = """
        extension \(visitorFullyQualifiedName) {
        \(generateOptionals(for: fields, structName: visitorFullyQualifiedName))
        }
        
        """
        
        print(code, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func isOptionalType(_ field: Field) -> Bool { field.type.isOptionalType }
    
    private func generateOptionals(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateOptional(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateOptional(_ field: Field, structName: String) -> String {
        let value = structName.components(separatedBy: ".").last!.lowercased()
        let optionField = field.type.hasSuffix("?") ?
            "\(value).\(field.name).toOption()" :
            "\(value).\(field.name)"
        
        return """
            static var \(field.name)Optional: Optional<\(structName), \(field.type.nonOptional)> {
                Optional(set: { $0.copy(with\(field.name.firstUppercased): .some($1)) },
                         getOrModify: { \(value) in
                             \(optionField).fold(
                                 { Either.left(\(value)) },
                                 Either.right)
                         })
            }
        """
    }
}

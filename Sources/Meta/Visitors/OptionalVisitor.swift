import SwiftSyntax

public class OptionalVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields.filter(isOptionalType)
        
        if fields.count > 0 {
            let optionalsCode = generateOptionals(for: fields, structName: structName)
            
            let code = """
            extension \(structName) {
            \(optionalsCode)
            }
            
            """
            print(code, to: &generatedCode)
        }
        
        return .skipChildren
    }
    
    private func isOptionalType(_ field: Field) -> Bool {
        return field.type.hasSuffix("?") ||
            field.type.hasPrefix("Option<")
    }
    
    private func generateOptionals(for fields: [Field], structName: String) -> String {
        fields.map { field in self.generateOptional(field, structName: structName) }.joined(separator: "\n\n")
    }
    
    private func generateOptional(_ field: Field, structName: String) -> String {
        let value = structName.lowercased()
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

fileprivate extension String {
    var nonOptional: String {
        if self.hasSuffix("?") {
            return String(self.dropLast())
        } else if self.hasPrefix("Option<") {
            return String(self.replacingOccurrences(of: "Option<", with: "").dropLast())
        } else {
            return self
        }
    }
}

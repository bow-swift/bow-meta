import SwiftSyntax

public class TraversalVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields.filter(isArrayType)
        
        if fields.count > 0 {
            let traversalsCode = generateTraversals(for: fields, structName: structName)
            
            let code = """
            extension \(structName) {
            \(traversalsCode)
            }
            
            """
            print(code, to: &generatedCode)
        }
        
        return .skipChildren
    }
    
    private func isArrayType(_ field: Field) -> Bool {
        return field.type.hasPrefix("[") ||
            field.type.hasPrefix("Array<") ||
            field.type.hasPrefix("ArrayK<") ||
            field.type.hasPrefix("NEA<") ||
            field.type.hasPrefix("NonEmptyArray<")
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

fileprivate extension String {
    var nonArray: String {
        if hasPrefix("[") {
            return String(dropFirst().dropLast())
        } else if hasPrefix("Array<") {
            return String(replacingOccurrences(of: "Array<", with: "").dropLast())
        } else if hasPrefix("ArrayK<") {
            return String(replacingOccurrences(of: "ArrayK<", with: "").dropLast())
        } else if hasPrefix("NEA<") {
            return String(replacingOccurrences(of: "NEA<", with: "").dropLast())
        } else if hasPrefix("NonEmptyArray<") {
            return String(replacingOccurrences(of: "NonEmptyArray<", with: "").dropLast())
        } else {
            return self
        }
    }
}

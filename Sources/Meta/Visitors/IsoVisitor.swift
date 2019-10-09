import SwiftSyntax

public class IsoVisitor: SyntaxVisitor, CodegenVisitor {
    public private(set) var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields
        
        let generated = """
                        extension \(structName) {
                            static var iso: \(type(structName, fields)) {
                                \(body(structName, fields))
                            }
                        }
                        
                        """
        
        print(generated, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func type(_ structName: String, _ fields: [Field]) -> String {
        let tuple = fields.map { field in field.type }.joined(separator: ", ")
        return "Iso<\(structName), (\(tuple))>"
    }
    
    private func body(_ structName: String, _ fields: [Field]) -> String {
        let instance = structName.lowercased()
        let tuple = fields.map { field in "\(instance).\(field.name)" }.joined(separator: ", ")
        let get = "{ \(instance) in (\(tuple))"
        let reverseGet = "\(structName).init"
        return """
               Iso(get: \(get),
                   reverseGet: \(reverseGet))
               """
    }
}

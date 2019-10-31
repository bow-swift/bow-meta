import SwiftSyntax

public class IsoVisitor: NestedDeclarationVisitor, CodegenVisitor {
    public private(set) var generatedCode: String = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = node.fields
        guard fields.count > 0 else { return visitorContinue }
        
        let structName = visitorFullyQualifiedName
        let generated = """
                        extension \(structName) {
                            static var iso: \(type(structName, fields)) {
                                \(body(structName, fields))
                            }
                        }
                        
                        """
        
        print(generated, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func type(_ structName: String, _ fields: [Field]) -> String {
        let tuple = fields.map { field in field.type }.joined(separator: ", ")
        return "Iso<\(structName), (\(tuple))>"
    }
    
    private func body(_ structName: String, _ fields: [Field]) -> String {
        let instance = structName.components(separatedBy: ".").last!.lowercased()
        let tuple = fields.map { field in "\(instance).\(field.name)" }.joined(separator: ", ")
        let get = "{ \(instance) in (\(tuple)) }"
        let reverseGet = "\(structName).init"
        return """
               Iso(get: \(get), reverseGet: \(reverseGet))
               """
    }
}

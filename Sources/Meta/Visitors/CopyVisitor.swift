import SwiftSyntax

public class CopyVisitor: NestedDeclarationVisitor, CodegenVisitor {
    public private(set) var generatedCode = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let fields = node.fields
        let structName = visitorFullyQualifiedName
        guard fields.count > 0 else { return visitorContinue }
        
        let generated = """
                        \(visitorModifier) extension \(structName) {
                            
                            init(\(initParameters(for: fields))) {
                                \(constructor(for: structName, with: fields))
                            }
                            
                            func copy(\(copyParameters(for: fields))) -> \(structName) {
                                \(body(for: structName, with: fields))
                            }
                        }
                        
                        """
        
        print(generated, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func initParameters(for members: [Field]) -> String {
        members.map { member in "_with\(member.name.firstUppercased) \(member.name): \(member.type)" }
               .joined(separator: ",\n\t\t ")
    }
    
    private func constructor(for structName: String, with members: [Field]) -> String {
        members.map { member in "self.\(member.name) = \(member.name)" }
               .joined(separator: "\n\t\t")
    }
    
    
    private func copyParameters(for members: [Field]) -> String {
        members.map { member in "with\(member.name.firstUppercased) \(member.name): \(member.type)? = nil" }
               .joined(separator: ",\n\t\t\t  ")
    }
    
    private func body(for structName: String, with members: [Field]) -> String {
        let copyArguments = members.map { member in "_with\(member.name.firstUppercased): \(member.name) ?? self.\(member.name)" }
                                   .joined(separator: ",\n\t\t\t  ")
        
        return "\(structName).init(\(copyArguments))"
    }
}

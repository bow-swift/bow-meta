import SwiftSyntax

public class CopyVisitor: SyntaxVisitor, CodegenVisitor {
    public private(set) var generatedCode = ""
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let fields = node.fields
        
        let generated = """
                        extension \(structName) {
                            func copy(\(copyParameters(for: fields))) -> \(structName) {
                                \(body(for: structName, with: fields))
                            }
                        }
                        
                        """
        print(generated, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func copyParameters(for members: [Field]) -> String {
        members.map { member in
            "with\(member.name.firstUppercased) \(member.name): \(member.type)? = nil"
        }.joined(separator: ",\n\t\t\t  ")
    }
    
    private func body(for structName: String, with members: [Field]) -> String {
        let copyArguments = members.map { member in
            "\(member.name): \(member.name) ?? self.\(member.name)"
        }.joined(separator: ",\n\t\t\t")
        
        return "\(structName)(\(copyArguments))"
    }
}

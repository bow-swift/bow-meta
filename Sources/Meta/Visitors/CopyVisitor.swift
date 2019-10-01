import SwiftSyntax

class CopyVisitor: SyntaxVisitor {
    private(set) var generatedCode = ""
    
    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        let structName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let members = node.members
        
        let generated = """
                        extension \(structName) {
                            func copy(\(copyParameters(for: members))) -> \(structName) {
                                \(body(for: structName, with: members))
                            }
                        }
                        
                        """
        print(generated, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func copyParameters(for members: [Member]) -> String {
        members.map { member in
            "with\(member.name.capitalized) \(member.name): \(member.type)? = nil"
        }.joined(separator: ",\n\t\t\t  ")
    }
    
    private func body(for structName: String, with members: [Member]) -> String {
        let copyArguments = members.map { member in
            "\(member.name): \(member.name) ?? self.\(member.name)"
        }.joined(separator: ",\n\t\t\t")
        
        return "\(structName)(\(copyArguments))"
    }
}

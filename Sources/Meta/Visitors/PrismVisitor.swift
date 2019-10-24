import SwiftSyntax

public class PrismVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let cases = node.cases
        guard cases.count > 0 else { return .skipChildren }
        
        let enumName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let prismsCode = generatePrisms(for: cases, enumName: enumName)
        
        let code =  """
                    extension \(enumName) {
                    \(prismsCode)
                    }
                    
                    """
        
        print(code, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func generatePrisms(for cases: [Case], enumName: String) -> String {
        cases.map { `case` in self.generatePrism(`case`, enumName: enumName) }.joined(separator: "\n\n")
    }
    
    private func generatePrism(_ case: Case, enumName: String) -> String {
        let hasAssociatedValues = `case`.associatedValues != nil
        return hasAssociatedValues ? generateAssociatedValuePrisms(in: `case`, enumName: enumName)
                                   : generatePrism(state: `case`.name, enumName: enumName)
    }
    
    private func generateAssociatedValuePrisms(in case: Case, enumName: String) -> String {
        
        func casePatternMatching(_ case: Case, associatedName: String, index: Int) -> String {
            let elements = `case`.associatedValues?.count ?? 0
            return (0..<elements).map { i in i == index ? associatedName : "_" }.joined(separator: ", ")
        }
        
        guard let associatedValues = `case`.associatedValues else { return "" }
        
        let associatedValuesPrims = associatedValues.enumerated().map { (index, associated) -> String in
            let associatedName = associated.name.isEmpty ? "\(associated.type.lowercased())\(index)" : associated.name
            let patternMatching = casePatternMatching(`case`, associatedName: associatedName, index: index)
            let state = `case`.name
            let type = associated.type
            
            return  """
                            static var \(associatedName)Prism: Prism<\(enumName), \(type)> {
                                Prism(getOrModify: { state in
                                    guard case let .\(state)(\(patternMatching)) = state else { return Either.left(state) }
                                    return Either.right(\(associatedName))
                                }, reverseGet: \(enumName).\(state))
                            }
                    """
        }
        
        return  """
                    
                    enum \(`case`.name.capitalized) {
                \(associatedValuesPrims.joined(separator: "\n\n"))
                    }
                """
    }
    
    private func generatePrism(state: String, enumName: String) -> String {
        """
            
            static var \(state)Prism: Prism<\(enumName), Void> {
                Prism(getOrModify: { state in
                    guard case .\(state) = state else { return Either.left(state) }
                    return Either.right(())
                }, reverseGet: { \(enumName).\(state) })
            }
        """
    }
}

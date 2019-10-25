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
        cases.map { `case` in self.generatePrism(`case`, enumName: enumName) }.joined(separator: "\n")
    }
    
    private func generatePrism(_ case: Case, enumName: String) -> String {
        let hasAssociatedValues = `case`.associatedValues != nil
        return hasAssociatedValues ? generateAssociatedValuesPrism(in: `case`, enumName: enumName)
                                   : generatePrism(state: `case`.name, enumName: enumName)
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
    
    private func generateAssociatedValuesPrism(in case: Case, enumName: String) -> String {
        guard let associatedValues = `case`.associatedValues else { return "" }
        
        let state = `case`.name
        let prismName = "\(state)Prism"
        let opticsTypes = associatedValues.map { field in field.type }
        let opticsTypesName = opticsTypes.count > 1 ? "(\(opticsTypes.joined(separator: ", ")))" : opticsTypes.first!
        
        let prism = """
                    
                        static var \(prismName): Prism<\(enumName), \(opticsTypesName)> {
                            Prism(getOrModify: { state in
                                \(opticsTypes.count > 1 ? "guard case let .\(state)\(opticsTypesName.lowercased()) = state else { return Either.left(state) }"
                                                        : "guard case let .\(state)(\(opticsTypesName.lowercased())) = state else { return Either.left(state) }"
                                )
                                return Either.right(\(opticsTypesName.lowercased()))
                            }, reverseGet: \(enumName).\(state))
                        }
                    """
        
        let associatedValuesOptics = generateAssociatedValuesOptics(inEnum: enumName, case: state, forPrism: prismName, withAssociatedValues: associatedValues)
        
        return  """
                \(prism)\(associatedValuesOptics)
                """
    }
    
    
    
    private func generateAssociatedValuesOptics(inEnum enumName: String, case caseName: String, forPrism prismName: String, withAssociatedValues associatedValues: [Field]) -> String {
        guard (2...10).contains(associatedValues.count) else { return "" }
        
        let associatedNames = associatedValues.map { associated -> String in
            associated.name.isEmpty ? associated.type.lowercased() : associated.name
        }
        
        let differentsNames = Array(Set(associatedNames)).count == associatedValues.count
        
        let optics = zip(associatedValues, associatedNames).enumerated().map { (index, associatedInfo) -> String in
            let ((_, type), associatedName) = associatedInfo
            let name = "\(associatedName)\(differentsNames ? "" : "\(index)")"
            return  """
                            static let \(name)Optional: Optional<\(enumName), \(type)> = \(prismName) + Tuple\(associatedValues.count)._\(index)
                    """
        }
        
        return  """
                
                
                    enum \(caseName.capitalized) {
                \(optics.joined(separator: "\n"))
                    }
                """
    }
}

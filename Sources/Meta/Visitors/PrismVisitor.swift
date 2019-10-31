import SwiftSyntax

public class PrismVisitor: NestedDeclarationVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let visitorContinue = super.visit(node)
        guard !node.isPrivate else { return .skipChildren }
        
        let cases = node.cases
        guard cases.count > 0 else { return visitorContinue }
        
        let code =  """
                    \(visitorModifier) extension \(visitorFullyQualifiedName) {
                    \(generatePrisms(for: cases, enumName: visitorFullyQualifiedName))
                    }
                    
                    """
        
        print(code, to: &generatedCode)
        
        return visitorContinue
    }
    
    private func generatePrisms(for cases: [Case], enumName: String) -> String {
        cases.map { `case` in self.generatePrism(`case`, enumName: enumName) }.joined(separator: "\n")
    }
    
    private func generatePrism(_ case: Case, enumName: String) -> String {
        let hasAssociatedValues = `case`.associatedValues.count > 0
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
        func combineTypes(_ types: [String]) -> String {
            guard types.count > 0 else { return "" }
            return types.count > 1 ? "(\(types.joined(separator: ", ")))" : types.first!
        }
        
        guard `case`.associatedValues.count > 0 else { return "" }
        
        let associatedValues = `case`.associatedValues
        let state = `case`.name
        let prismName = "\(state)Prism"
        let opticsTypes = associatedValues.map { field in field.type }
        let opticsParameters = opticsTypes.enumerated().map { index, type in "\(type.lowercased().replacingOccurrences(of: "?", with: ""))\(index)" }
        let opticsTypesName = combineTypes(opticsTypes)
        let opticsParametersName = combineTypes(opticsParameters)
                                                   
        let prism = """
                    
                        static var \(prismName): Prism<\(enumName), \(opticsTypesName)> {
                            Prism(getOrModify: { state in
                                \(opticsTypes.count > 1 ? "guard case let .\(state)\(opticsParametersName) = state else { return Either.left(state) }"
                                                        : "guard case let .\(state)(\(opticsParametersName)) = state else { return Either.left(state) }"
                                )
                                return Either.right(\(opticsParametersName))
                            }, reverseGet: \(enumName).\(state))
                        }
                    """
        
        let associatedValuesOptics = generateAssociatedValuesOptics(inEnum: enumName, case: state, forPrism: prismName, withAssociatedValues: associatedValues)
        
        return  """
                \(prism)\(associatedValuesOptics)
                """
    }
    
    private func generateAssociatedValuesOptics(inEnum enumName: String, case caseName: String, forPrism prismName: String, withAssociatedValues associatedValues: [Field]) -> String {
        let tuplesArityRange = (2...10) // Bow has defined optics over tuples of arity 2-10
        guard tuplesArityRange.contains(associatedValues.count) else { return "" }
        
        let associatedNames = associatedValues.map { associated -> String in
            associated.name.isEmpty ? associated.type.lowercased().replacingOccurrences(of: "?", with: "")
                                    : associated.name
        }
        
        let differentsNames = Array(Set(associatedNames)).count == associatedValues.count
        
        let optics = zip(associatedValues, associatedNames).enumerated().map { (index, associatedInfo) -> String in
            let (field, associatedName) = associatedInfo
            let name = "\(associatedName)\(differentsNames ? "" : "\(index)")"
            return  """
                            static let \(name)Optional: Optional<\(enumName), \(field.type)> = \(prismName) + Tuple\(associatedValues.count)._\(index)
                    """
        }
        
        return  """
                
                
                    enum \(caseName.firstUppercased) {
                \(optics.joined(separator: "\n"))
                    }
                """
    }
}

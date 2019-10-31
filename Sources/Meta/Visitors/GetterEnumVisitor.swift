import SwiftSyntax

public class GetterEnumVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let cases = node.cases
        let commonFields = commonAssociatedFields(in: cases)
        guard commonFields.count > 0 else { return .skipChildren }
        
        let enumName = node.identifier.description.trimmingCharacters
        let code =  """
                    extension \(enumName) {
                    \(generateGetters(for: commonFields, in: cases, forEnum: enumName))
                    \(generateIndividualGetters(for: commonFields, in: cases, forEnum: enumName))
                    }
                    
                    """

        print(code, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func commonAssociatedFields(in cases: [Case]) -> [Field] {
        let associatedFields: [[Field]] = cases.map { `case` in
            `case`.associatedValues.filter { field in !field.name.isEmpty }
        }
        
        let commonsFields = associatedFields.k().reduceLeftOption { partial, types in
            Array(Set(partial).intersection(Set(types)))
        }.getOrElse([])
        
        return cases.first?.associatedValues.filter { field in commonsFields.contains(field) } ?? []
    }
    
    private func generateGetters(for fields: [Field], in cases: [Case], forEnum enumName: String) -> String {
        func combineValues(_ values: [String]) -> String {
            let joined = values.joined(separator: ", ")
            return values.count > 1 ? "(\(joined))" : joined
        }
        
        func extractFields(_ fields: [Field], inCase case: Case) -> String {
            let getterParametersName = combineValues(fields.map { field in field.name })
            let parameters = `case`.associatedValues.map { field in fields.contains(field) ? field.name : "_" }.joined(separator: ", ")
            return "        case let .\(`case`.name)(\(parameters)): return \(getterParametersName)"
        }
        
        func opticGetter(for fields: [Field], in cases: [Case], forEnum enumName: String, namedElements: Bool) -> String {
            let getterName = opticGetterName(forFields: fields, inEnum: enumName, namedElements: namedElements)
            let getterTypes = namedElements ? combineValues(fields.map { field in "\(field.name): \(field.type)" })
                                            : combineValues(fields.map { field in field.type })
            
            return  """
                    
                        static var \(getterName) = Getter<\(enumName), \(getterTypes)> { state in
                            switch state {
                    \(cases.map { `case` in extractFields(fields, inCase: `case`) }.joined(separator: "\n") )
                            }
                        }
                    """
        }
        
        
        return  """
                    \(opticGetter(for: fields, in: cases, forEnum: enumName, namedElements: false))
                    \(fields.count > 1 ? opticGetter(for: fields, in: cases, forEnum: enumName, namedElements: true) : "")
                """
    }
    
    private func generateIndividualGetters(for fields: [Field], in cases: [Case], forEnum enumName: String) -> String {
        let tuplesArityRange = (2...10) // Bow has defined optics over tuples of arity 2-10
        guard tuplesArityRange.contains(fields.count) else { return "" }
        
        let getterName = opticGetterName(forFields: fields, inEnum: enumName, namedElements: false)
        let getters = fields.enumerated().map { (index, field) in
            """
                static let \(field.name)Getter: Getter<\(enumName), \(field.type)> = \(getterName) + Tuple\(fields.count)._\(index)
            """
        }
        
        return  """
                
                \(getters.joined(separator: "\n"))
                """
    }
    
    private func opticGetterName(forFields fields: [Field], inEnum enumName: String, namedElements: Bool) -> String {
        fields.count > 1 ? "fields\(namedElements ? "Named" : "")Getter" : "\(fields.first!.name)Getter"
    }
}

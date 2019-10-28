import SwiftSyntax
import Bow


public class GetterEnumVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let cases = node.cases
        let commonFields = commonAssociatedFields(in: cases)
        guard commonFields.count > 0 else { return .skipChildren }
        
        let enumName = node.identifier.description.trimmingCharacters(in: .whitespacesAndNewlines)
        let code =  """
                    extension \(enumName) {
                    \(generateGetters(for: commonFields, in: cases, forEnum: enumName))
                    }
                    
                    """

        print(code, to: &generatedCode)
        
        return .skipChildren
    }
    
    private func commonAssociatedFields(in cases: [Case]) -> [Field] {
        let associatedFields: [[Field]] = cases.map { `case` in
            `case`.associatedValues.filter { field in !field.name.isEmpty }
        }
        
        return associatedFields.k().reduceLeftOption { partial, types in
            Array(Set(partial).intersection(Set(types)))
        }.getOrElse([])
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
        
        let getterTypesName = combineValues(fields.map { field in field.type })
        let getterName = generateGetterName(forFields: fields, inEnum: enumName)
        
        return  """
                    static var \(getterName) = Getter<\(enumName), \(getterTypesName)> { state in
                        switch state {
                \(cases.map { `case` in extractFields(fields, inCase: `case`) }.joined(separator: "\n") )
                        }
                    }
                """
    }
    
    private func generateGetterName(forFields fields: [Field], inEnum enumName: String) -> String {
        fields.count > 1 ? "\(enumName.firstLowercased)FieldsGetter" : "\(enumName.firstLowercased)\(fields.first!.name.capitalized)Getter"
    }
}

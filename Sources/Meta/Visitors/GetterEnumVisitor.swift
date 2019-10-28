import SwiftSyntax
import Bow


public class GetterEnumVisitor: SyntaxVisitor, CodegenVisitor {
    private(set) public var generatedCode: String = ""
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        let cases = node.cases
        guard cases.count > 0 else { return .skipChildren }
        
        let associatedTypes: [[String]] = node.cases.map { `case` in
            `case`.associatedValues.compactMap { tuple in
                guard !tuple.name.isEmpty else { return nil }
                return "\(tuple.name):\(tuple.type)".trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        
        let commonTypes = associatedTypes.k().reduceLeftOption { partial, types in
            Array(Set(partial).intersection(Set(types)))
        }.getOrElse([]).compactMap { type in
            type.components(separatedBy: ":").last
        }
        
        let code = ""
        
        print(code, to: &generatedCode)
        
        return .skipChildren
    }
}

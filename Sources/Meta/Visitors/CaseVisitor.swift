import SwiftSyntax

public typealias Case = (name: String, associatedValues: [Field])

public extension EnumDeclSyntax {
    var cases: [Case] {
        let visitor = CaseVisitor()
        self.walk(visitor)
        return visitor.cases
    }
}

public class CaseVisitor: SyntaxVisitor {
    public private(set) var cases: [Case] = []
    
    override public func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
        let cases: [Case] = node.elements.reduce(into: []) { partial, element in
            let newCase = (name: element.identifier.description, associatedValues: element.associatedValues)
            partial.append(newCase)
        }
        
        self.cases.append(contentsOf: cases)
        return .skipChildren
    }
    
    override public func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        return .skipChildren
    }
}


extension EnumCaseElementSyntax {
    
    var associatedValues: [Field] {
        guard let parameterList = associatedValue?.parameterList else { return [] }
        
        return parameterList.compactMap { parameter in
            guard let type = parameter.type?.description else { return nil }
            let paramName = parameter.firstName?.description ?? ""
            return Field(name: paramName, type: type)
        }
    }
}

import SwiftSyntax

public struct Case: Equatable {
    let name: String
    let associatedValues: [Field]
    
    public init(name: String, associatedValues: [Field]) {
        self.name = name
        self.associatedValues = associatedValues
    }
}


public extension EnumDeclSyntax {
    var cases: [Case] {
        let visitor = CaseVisitor(self)
        self.walk(visitor)
        return visitor.cases
    }
}

public class CaseVisitor: SyntaxVisitor {
    public private(set) var cases: [Case] = []
    private let node: EnumDeclSyntax
    
    public init(_ node: EnumDeclSyntax) {
        self.node = node
    }
    
    override public func visit(_ node: EnumCaseDeclSyntax) -> SyntaxVisitorContinueKind {
        let visibilityModifier = Array(node.modifiers).modifier
        let cases: [Case] = node.elements.reduce(into: []) { partial, element in
            let newCase = Case(name: element.identifier.text.trimmingCharacters,
                               associatedValues: element.associatedValues(visibilityModifier: visibilityModifier))
            partial.append(newCase)
        }
        
        self.cases.append(contentsOf: cases)
        return .skipChildren
    }
    
    public override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind { .skipChildren }
    public override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        self.node == node ? .visitChildren : .skipChildren
    }
}


extension EnumCaseElementSyntax {
    
    func associatedValues(visibilityModifier: VisibilityModifier) -> [Field] {
        guard let parameterList = associatedValue?.parameterList else { return [] }
        
        return parameterList.compactMap { parameter in
            guard let type = parameter.type?.description.trimmingCharacters else { return nil }
            let paramName = parameter.firstName?.text.trimmingCharacters ?? ""
            
            return Field(name: paramName,
                         type: type,
                         modifier: visibilityModifier,
                         inmutableValue: true)
        }
    }
}

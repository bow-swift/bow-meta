import SwiftSyntax

public extension NodeSyntax {
    var hasChildren: Bool {
        let visitor = ChildVisitor()
        self.walk(visitor)
        return visitor.hasChildren
    }
}

public class ChildVisitor: SyntaxVisitor {
    public private(set) var enumNodes: [EnumDeclSyntax] = []
    public private(set) var structNodes: [StructDeclSyntax] = []
    
    override public func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        self.enumNodes.append(node)
        return hasChildren ? .skipChildren : .visitChildren
    }
    
    override public func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        self.structNodes.append(node)
        return hasChildren ? .skipChildren : .visitChildren
    }
    
    override public func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        return hasChildren ? .skipChildren : .visitChildren
    }
    
    override public func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        return .skipChildren
    }
    
    public var hasChildren: Bool { structNodes.count > 1 || enumNodes.count > 1 }
}

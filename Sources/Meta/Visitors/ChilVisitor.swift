import SwiftSyntax


public extension DeclSyntax where Self == EnumDeclSyntax {
    var hasChildren: Bool {
        let visitor = ChilVisitor()
        self.walk(visitor)
        return visitor.hasChildren
    }
}

public extension DeclSyntax where Self == StructDeclSyntax {
    var hasChildren: Bool {
        let visitor = ChilVisitor()
        self.walk(visitor)
        return visitor.hasChildren
    }
}

public extension DeclSyntax where Self == ClassDeclSyntax {
    var hasChildren: Bool {
        let visitor = ChilVisitor()
        self.walk(visitor)
        return visitor.hasChildren
    }
}


public class ChilVisitor: SyntaxVisitor {
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

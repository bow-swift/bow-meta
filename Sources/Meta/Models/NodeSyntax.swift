import SwiftSyntax

public protocol NodeSyntax {
    var id: String { get }
    var hasChildren: Bool { get }
    var syntaxModifiers: [SyntaxModifier] { get }
    var isPrivate: Bool { get }
    
    var identifier: TokenSyntax { get }
    func walk(_ visitor: SwiftSyntax.SyntaxVisitor)
}

extension NodeSyntax {
    public var isPrivate: Bool { syntaxModifiers.modifier == .private }
    public var id: String { identifier.description.trimmingCharacters(in: .whitespacesAndNewlines) }
}


extension ClassDeclSyntax: NodeSyntax {
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

extension StructDeclSyntax: NodeSyntax {
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

extension EnumDeclSyntax: NodeSyntax {
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

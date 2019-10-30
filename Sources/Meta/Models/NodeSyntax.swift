import SwiftSyntax

public protocol NodeSyntax {
    var name: String { get }
    var hasChildren: Bool { get }
    var syntaxModifiers: [SyntaxModifier] { get }
    var isPrivate: Bool { get }
}

extension NodeSyntax {
    public var isPrivate: Bool { syntaxModifiers.modifier == .private }
}


extension ClassDeclSyntax: NodeSyntax {
    public var name: String { identifier.description }
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

extension StructDeclSyntax: NodeSyntax {
    public var name: String { identifier.description }
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

extension EnumDeclSyntax: NodeSyntax {
    public var name: String { identifier.description }
    public var syntaxModifiers: [SyntaxModifier] { Array(modifiers?.modifiers ?? []) }
}

public class TraversalGenerator {
    public init() {}
}

extension TraversalGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension TraversalGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: TraversalVisitor(),
                             requiredImports: Set(["import BowOptics"]))
    }
}

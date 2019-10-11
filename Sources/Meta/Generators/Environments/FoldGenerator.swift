public class FoldGenerator {
    public init() {}
}

extension FoldGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension FoldGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: FoldVisitor(),
                             requiredImports: Set(["import BowOptics"]))
    }
}

public class PrismGenerator {
    public init() {}
}

extension PrismGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension PrismGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: PrismVisitor(),
                             requiredImports: Set(["import BowOptics"]))
    }
}

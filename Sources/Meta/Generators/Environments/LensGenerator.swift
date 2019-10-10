public class LensGenerator {
    public init() {}
}

extension LensGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension LensGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: LensVisitor(),
                             requiredImports: Set(["import BowOptics"]))
    }
}

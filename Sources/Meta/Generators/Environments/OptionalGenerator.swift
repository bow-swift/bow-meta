public class OptionalGenerator {
    public init() {}
}

extension OptionalGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension OptionalGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: OptionalVisitor(),
                             requiredImports: Set(["import Bow",
                                                   "import BowOptics"]))
    }
}

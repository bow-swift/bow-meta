public class GetterEnumGenerator {
    public init() {}
}

extension GetterEnumGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension GetterEnumGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: GetterEnumVisitor(),
                             requiredImports: Set(["import Bow",
                                                   "import BowOptics"]))
    }
}

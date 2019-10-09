public class IsoGenerator {
    public init() {}
}

extension IsoGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension IsoGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxGenerator(visitor: IsoVisitor(), requiredImports: Set(["import BowOptics"]))
    }
}

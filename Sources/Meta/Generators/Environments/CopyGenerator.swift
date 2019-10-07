public class CopyGenerator {
    public init() {}
}

extension CopyGenerator: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension CopyGenerator: HasCodeGenerator {
    public var generator: CodeGenerator {
        SwiftSyntaxCopyGenerator()
    }
}

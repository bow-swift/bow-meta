public struct Environment {}

extension Environment: HasFileSystem {
    public var fileSystem: FileSystem {
        MacFileSystem()
    }
}

extension Environment: HasCopyGenerator {
    public var copyGenerator: CopyGenerator {
        SwiftSyntaxCopyGenerator()
    }
}

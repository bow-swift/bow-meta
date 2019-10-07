import Foundation
import Bow
import BowEffects
import SwiftSyntax

public typealias CopyDependencies = HasFileSystem & HasCopyGenerator

public func generateCopyMethod<D: CopyDependencies>(forFilesIn directory: String, saveIn output: String) -> RIO<D, Void> {
    let env = RIO<D, D>.var()
    let code = RIO<D, String>.var()
    
    return binding(
        env  <- ask(),
        code <- generateCopyMethod(forFilesIn: directory),
             |<-env.get.fileSystem.write(code: code.get, in: output).widen(),
        yield: ())^
}

public func generateCopyMethod<D: CopyDependencies>(forFilesIn directory: String) -> RIO<D, String> {
    let env = RIO<D, D>.var()
    let files = RIO<D, [String]>.var()
    let code = RIO<D, String>.var()
    let imports = RIO<D, String>.var()
    let result = RIO<D, String>.var()
    
    return binding(
        env     <- ask(),
        files   <- env.get.fileSystem.getFiles(in: directory, recursiveSearch: true).widen(),
        imports <- env.get.copyGenerator.generateImports(forFiles: files.get).widen(),
        code    <- env.get.copyGenerator.generate(forFiles: files.get).widen(),
        result  <- env.get.copyGenerator.pack(code: code.get, imports: imports.get).widen(),
        yield: result.get)^
}

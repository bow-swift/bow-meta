import Foundation
import Bow
import BowEffects
import SwiftSyntax

public typealias CodegenDependencies = HasFileSystem & HasCodeGenerator

public func generateCode<D: CodegenDependencies>(forFilesIn directory: String, saveIn output: String) -> RIO<D, Void> {
    let env  = RIO<D, D>.var()
    let code = RIO<D, String>.var()
    
    return binding(
        env  <- ask(),
        code <- generateCode(forFilesIn: directory),
             |<-env.get.fileSystem.write(code: code.get, in: output).widen(),
        yield: ())^
}

public func generateCode<D: CodegenDependencies>(forFilesIn directory: String) -> RIO<D, String> {
    let env     = RIO<D, D>.var()
    let files   = RIO<D, [String]>.var()
    let code    = RIO<D, String>.var()
    let imports = RIO<D, String>.var()
    let result  = RIO<D, String>.var()
    
    return binding(
        env     <- ask(),
        files   <- env.get.fileSystem.getFiles(in: directory, recursiveSearch: true).widen(),
        imports <- env.get.generator.generateImports(forFiles: files.get).widen(),
        code    <- env.get.generator.generate(forFiles: files.get).widen(),
        result  <- env.get.generator.pack(code: code.get, imports: imports.get).widen(),
        yield: result.get)^
}

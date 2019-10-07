import Foundation
import Bow
import BowEffects
import SwiftSyntax

public func generateCopyMethod(forFilesIn directory: String, saveIn output: String) -> Task<Void> {
    let code = Task<String>.var()
    
    return binding(
        code <- generateCopyMethod(forFilesIn: directory),
             |<-write(code: code.get, in: output),
        yield: ())^
}

public func generateCopyMethod(forFilesIn directory: String) -> Task<String> {
    let files = Task<[String]>.var()
    let code = Task<String>.var()
    let imports = Task<String>.var()
    let result = Task<String>.var()
    
    return binding(
        files   <- getFiles(in: directory),
        imports <- generateImports(forFiles: files.get),
        code    <- generateCopyMethod(forFiles: files.get),
        result  <- pack(code: code.get, imports: imports.get),
        yield: result.get)^
}

private func getFiles(in directory: String) -> Task<[String]> {
    FileManager.default.contentsOfDirectoryIO(atPath: directory)
        .map { files in files.map { file in "\(directory)/\(file)" } }
        .flatMap(searchSubdirectories(of:))^
}

private func searchSubdirectories(of files: [String]) -> Task<[String]> {
    files.traverse { item -> Task<[String]> in
        if URL(fileURLWithPath: item).hasDirectoryPath {
            return getFiles(in: item)
        } else {
            return Task.pure([item])^
        }
    }.map { files in files.flatMap(id) }^
}

private func generateImports(forFiles files: [String]) -> Task<String> {
    files.map(URL.init(fileURLWithPath:))
        .traverse(generateImport(forFile:))
        .map { list in
            list.combineAll()
                .sorted()
                .joined(separator: "\n")
        }^
}

private func generateImport(forFile file: URL) -> Task<Set<String>> {
    Task.invoke {
        let visitor = ImportVisitor()
        let ast = try SyntaxTreeParser.parse(file)
        ast.walk(visitor)
        return visitor.imports
    }.handleError { _ in Set() }^
}

private func generateCopyMethod(forFiles files: [String]) -> Task<String> {
    files.map(URL.init(fileURLWithPath:))
        .traverse(generateCopyMethod(for:))
        .map { codes in codes.joined(separator: "\n") }^
}

private func generateCopyMethod(for file: URL) -> Task<String> {
    func generateCode(for file: URL) -> Task<String> {
        Task.invoke {
            let ast = try SyntaxTreeParser.parse(file)
            let visitor = CopyVisitor()
            ast.walk(visitor)
            if visitor.generatedCode.isEmpty {
                return ""
            } else {
                return """
                // MARK: - Generated from file \(file.lastPathComponent)
                
                \(visitor.generatedCode)
                """
            }
        }.handleError { _ in "" }^
    }
    
    let code = Task<String>.var()
    
    return binding(
             |<-ConsoleIO.print("Generating code for file: \(file.lastPathComponent)"),
        code <- generateCode(for: file),
        yield: code.get)^
}

private func pack(code: String, imports: String) -> Task<String> {
    Task.invoke {
        """
        \(imports)
        
        \(code)
        """
    }
}

private func write(code: String, in output: String) -> Task<Void> {
    Task.invoke {
        try code.write(toFile: "\(output)/CopyGenerated.swift", atomically: true, encoding: .utf8)
    }
}

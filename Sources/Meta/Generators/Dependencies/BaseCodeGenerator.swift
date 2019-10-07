import Foundation
import Bow
import BowEffects
import SwiftSyntax

class BaseCodeGenerator {}

extension BaseCodeGenerator: CodeGenerator {
    func generateImports(forFiles files: [String]) -> RIO<Any, String> {
        files.map(URL.init(fileURLWithPath:))
            .traverse(generateImport(forFile:))
            .map { list in
                list.combineAll()
                    .sorted()
                    .joined(separator: "\n")
            }^
    }
    
    func pack(code: String, imports: String) -> RIO<Any, String> {
        Task.invoke {
            """
            \(imports)
            
            \(code)
            """
        }.env
    }

    private func generateImport(forFile file: URL) -> RIO<Any, Set<String>> {
        Task.invoke {
            let visitor = ImportVisitor()
            let ast = try SyntaxTreeParser.parse(file)
            ast.walk(visitor)
            return visitor.imports
        }.handleError { _ in Set() }^.env
    }
}

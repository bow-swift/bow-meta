import Foundation
import Bow
import BowEffects
import SwiftSyntax

class BaseCodeGenerator: CodeGenerator {
    func generate(for file: URL) -> RIO<Any, String> {
        fatalError("Implement generate(for:) in subclasses")
    }
    
    func generateImport(forFile file: URL) -> RIO<Any, Set<String>> {
        Task.invoke {
            let visitor = ImportVisitor()
            let ast = try SyntaxTreeParser.parse(file)
            ast.walk(visitor)
            return visitor.imports
        }.handleError { _ in Set() }^.env
    }
    
    func pack(code: String, imports: String) -> RIO<Any, String> {
        Task.invoke {
            """
            \(imports)
            
            \(code)
            """
        }.env
    }
}

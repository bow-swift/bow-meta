import Foundation
import SwiftSyntax
import Bow
import BowEffects

class SwiftSyntaxGenerator: CodeGenerator {
    private let makeVisitor: () -> CodegenVisitor
    
    init(visitor: @autoclosure @escaping () -> CodegenVisitor) {
        self.makeVisitor = visitor
    }
    
    func generate(for file: URL) -> RIO<Any, String> {
        let code = Task<String>.var()
        
        return binding(
                 |<-ConsoleIO.print("Generating code for file: \(file.lastPathComponent)"),
                 code <- self.runVisitor(for: file),
            yield: code.get)^.env
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
    
    func runVisitor(for file: URL) -> Task<String> {
        Task.invoke {
            let ast = try SyntaxTreeParser.parse(file)
            let visitor = self.makeVisitor()
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
}

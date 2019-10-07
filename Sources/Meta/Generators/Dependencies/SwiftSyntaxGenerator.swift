import Foundation
import SwiftSyntax
import Bow
import BowEffects

class SwiftSyntaxGenerator: BaseCodeGenerator {
    private let makeVisitor: () -> CodegenVisitor
    
    init(visitor: @autoclosure @escaping () -> CodegenVisitor) {
        self.makeVisitor = visitor
    }
    
    override func generate(for file: URL) -> RIO<Any, String> {
        self.generateCopyMethod(for: file).env
    }
    
    private func generateCopyMethod(for file: URL) -> Task<String> {
        func generateCode(for file: URL) -> Task<String> {
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
        
        let code = Task<String>.var()
        
        return binding(
                 |<-ConsoleIO.print("Generating code for file: \(file.lastPathComponent)"),
            code <- generateCode(for: file),
            yield: code.get)^
    }
}

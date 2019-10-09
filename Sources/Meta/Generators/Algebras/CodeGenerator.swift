import Foundation
import BowEffects

public protocol CodeGenerator {
    func generateImport(forFile file: URL) -> RIO<Any, Set<String>>
    func generate(for file: URL) -> RIO<Any, String>
    func pack(code: String, imports: String) -> RIO<Any, String>
}

public protocol HasCodeGenerator {
    var generator: CodeGenerator { get }
}

extension CodeGenerator {
    func generate(forFiles files: [String]) -> RIO<Any, String> {
        RIO { _ in
            files.map(URL.init(fileURLWithPath:))
                .traverse { url in self.generate(for: url).provide(()) }
                .map { codes in codes.joined(separator: "\n") }^
        }
    }
    
    func generateImports(forFiles files: [String]) -> RIO<Any, String> {
        files.map(URL.init(fileURLWithPath:))
            .traverse { file in self.generateImport(forFile: file).provide(()) }
            .map { list in
                list.combineAll()
                    .sorted()
                    .joined(separator: "\n")
        }^.env
    }
}

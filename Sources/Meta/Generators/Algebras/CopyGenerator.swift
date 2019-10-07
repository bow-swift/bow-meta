import Foundation
import BowEffects

public protocol CopyGenerator: CodeGenerator {
    func generate(for file: URL) -> RIO<Any, String>
}

public protocol HasCopyGenerator {
    var copyGenerator: CopyGenerator { get }
}

extension CopyGenerator {
    func generate(forFiles files: [String]) -> RIO<Any, String> {
        RIO { _ in
            files.map(URL.init(fileURLWithPath:))
                .traverse { url in self.generate(for: url).provide(()) }
                .map { codes in codes.joined(separator: "\n") }^
        }
    }
}

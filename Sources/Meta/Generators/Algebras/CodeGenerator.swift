import BowEffects

public protocol CodeGenerator {
    func generateImports(forFiles files: [String]) -> RIO<Any, String>
    func pack(code: String, imports: String) -> RIO<Any, String>
}

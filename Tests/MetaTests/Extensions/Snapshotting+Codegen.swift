import Foundation
import SnapshotTesting
import SwiftSyntax
import Meta
import BowEffects


extension Snapshotting where Value == URL, Format == String {
    static var copyMethod: Snapshotting<URL, String> { .generatedCode(visitor: CopyVisitor()) }
    static var fold: Snapshotting<URL, String> { .generatedCode(visitor: FoldVisitor()) }
    static var getterEnum: Snapshotting<URL, String> { .generatedCode(visitor: GetterEnumVisitor()) }
    static var iso: Snapshotting<URL, String> { .generatedCode(visitor: IsoVisitor()) }
    static var lens: Snapshotting<URL, String> { .generatedCode(visitor: LensVisitor()) }
    static var optional: Snapshotting<URL, String> { .generatedCode(visitor: OptionalVisitor()) }
    static var prism: Snapshotting<URL, String> { .generatedCode(visitor: PrismVisitor()) }
    static var traversal: Snapshotting<URL, String> { .generatedCode(visitor: TraversalVisitor()) }
}


extension Snapshotting where Value == URL, Format == String {
    static func generatedCode<T: CodegenVisitor>(visitor: T) -> Snapshotting<URL, String> {
        Snapshotting<String, String>.lines.pullback { (url: URL) -> String in
            let tree = try! SyntaxTreeParser.parse(url)
            tree.walk(visitor)
            return visitor.generatedCode
        }
    }
    
    static func generatedCode<D: CodegenDependencies>(using environment: D) -> Snapshotting<URL, String> {
        var strategy = Snapshotting<String, String>.lines.pullback { (url: URL) -> String in
            try! generateCode(forFilesIn: url.path)
                .provide(environment)
                .unsafeRunSync()
        }
        strategy.pathExtension = "swift"
        return strategy
    }
}

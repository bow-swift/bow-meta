import Foundation
import SnapshotTesting
import SwiftSyntax
import Meta
import BowEffects

extension Snapshotting where Value == URL, Format == String {
    static func generatedCode<T: CodegenVisitor>(visitor: T) -> Snapshotting<URL, String> {
        Snapshotting<String, String>.lines.pullback { (url: URL) -> String in
            let tree = try! SyntaxTreeParser.parse(url)
            tree.walk(visitor)
            return visitor.generatedCode
        }
    }
    
    static let copyMethod: Snapshotting<URL, String> = .generatedCode(visitor: CopyVisitor())
    
    static let iso: Snapshotting<URL, String> = .generatedCode(visitor: IsoVisitor())
    
    static let lens: Snapshotting<URL, String> = .generatedCode(visitor: LensVisitor())
    
    static let optional: Snapshotting<URL, String> = .generatedCode(visitor: OptionalVisitor())
    
    static let traversal: Snapshotting<URL, String> = .generatedCode(visitor: TraversalVisitor())
    
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

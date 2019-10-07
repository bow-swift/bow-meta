import Foundation
import SnapshotTesting
import SwiftSyntax
import Meta

extension Snapshotting where Value == URL, Format == String {
    static func generatedCode<T: Codegen>(_ visitor: T) -> Snapshotting<URL, String> {
        var strategy = Snapshotting<String, String>.lines.pullback { (url: URL) -> String in
            let tree = try! SyntaxTreeParser.parse(url)
            tree.walk(visitor)
            return visitor.generatedCode
        }
        strategy.pathExtension = "swift"
        return strategy
    }
    
    static let copyMethod: Snapshotting<URL, String> = .generatedCode(CopyVisitor())
}

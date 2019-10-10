import Foundation

/// Get paths for testing
extension URL {
    private static var base: URL { URL(fileURLWithPath: String(#file)).deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent() }
    
    static func currentFile(_ file: StaticString = #file) -> URL { URL(fileURLWithPath: "\(file)") }
    static let meta   = URL.base.appendingPathComponent("MetaTests")
    static let optics = URL.base.appendingPathComponent("OpticsGeneratorTests")
}

/// Concat to url path
extension URL {
    enum File: String {
        case article = "Article.swift"
        case author = "Author.swift"
        case company = "Subfolder/Company.swift"
    }
    
    var fixtures: URL { appendingPathComponent("Fixtures") }
    func file(_ file: File) -> URL { appendingPathComponent(file.rawValue) }
}

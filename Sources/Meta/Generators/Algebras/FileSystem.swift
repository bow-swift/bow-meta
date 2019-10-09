import Foundation
import Bow
import BowEffects

public protocol FileSystem {
    func getFiles(in directory: String, recursiveSearch: Bool) -> RIO<Any, [String]>
    func write(code: String, in output: String) -> RIO<Any, Void>
}

public protocol HasFileSystem {
    var fileSystem: FileSystem { get }
}

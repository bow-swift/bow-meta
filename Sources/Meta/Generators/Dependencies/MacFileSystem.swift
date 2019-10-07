import Foundation
import Bow
import BowEffects

class MacFileSystem {}

extension MacFileSystem: FileSystem {
    func getFiles(in directory: String, recursiveSearch: Bool) -> RIO<Any, [String]> {
        self._getFiles(in: directory, recursiveSearch: recursiveSearch).env
    }
    
    private func _getFiles(in directory: String, recursiveSearch: Bool) -> Task<[String]> {
        let task = FileManager.default.contentsOfDirectoryIO(atPath: directory)
            .map { files in files.map { file in "\(directory)/\(file)" } }
            
        if recursiveSearch {
            return task.flatMap(searchSubdirectories(of:))^
        } else {
            return task^
        }
    }

    private func searchSubdirectories(of files: [String]) -> Task<[String]> {
        files.traverse { item -> Task<[String]> in
            if URL(fileURLWithPath: item).hasDirectoryPath {
                return self._getFiles(in: item, recursiveSearch: true)
            } else {
                return Task.pure([item])^
            }
        }.map { files in files.flatMap(id) }^
    }
    
    func write(code: String, in output: String) -> EnvIO<Any, Error, Void> {
        Task.invoke {
            try code.write(toFile: "\(output)/CopyGenerated.swift", atomically: true, encoding: .utf8)
        }.env
    }
}

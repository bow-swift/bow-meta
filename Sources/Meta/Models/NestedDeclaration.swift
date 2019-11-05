import SwiftSyntax

public class NestedDeclaration {
    private var nodesModifier: [ModifierListSyntax] = []
    private var parentsIds: [String] = []
    
    var fullyQualifiedName: String { parentsIds.joined(separator: ".") }
    var modifier: String { Array(nodesModifier.flatMap { $0.modifiers }).modifier.description }
    
    func append(node: NodeSyntax) {
        parentsIds.append(node.id)
    }
    
    func append(node: ModifierListSyntax) {
        self.nodesModifier.append(node)
    }
    
    func pop(node: NodeSyntax) {
        guard let lastId = parentsIds.last, lastId == node.id else { return }
        _ = parentsIds.popLast()
    }
    
    func pop(node: ModifierListSyntax) {
        guard let index = nodesModifier.enumerated().first(where: {offset, element in element == node })?.offset else { return }
        nodesModifier.remove(at: index)
    }
}

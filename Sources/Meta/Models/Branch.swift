import SwiftSyntax

public class Branch {
    private var nodesModifier: [ModifierListSyntax]
    private var familyName: [String]
    
    var nodeFamilyName: String { familyName.joined(separator: ".") }
    var nodeModifier: String { Array(nodesModifier.flatMap { $0.modifiers }).modifier.description }
    
    init() {
        self.nodesModifier = []
        self.familyName = []
    }
    
    func append(node: NodeSyntax) {
        familyName.append(node.name.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func append(node: ModifierListSyntax) {
        self.nodesModifier.append(node)
    }
    
    func pop(node: NodeSyntax) {
        _ = familyName.popLast()
    }
    
    func pop(node: ModifierListSyntax) {
        guard let index = nodesModifier.enumerated().first(where: {offset, element in element == node })?.offset else { return }
        nodesModifier.remove(at: index)
    }
}

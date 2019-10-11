import Foundation

enum SocialNetwork {
    case twitter(String)
    case github(String)
}

struct Author {
    let name: String
    let social: Array<SocialNetwork>
    
    var hasTwitter: Bool {
        social.map { item in
            guard case .twitter(_) = item else { return false }
            return true
        }.reduce(false) { x, y in x || y }
    }
    
    func prettyPrintSocial() -> String {
        let str: [String] = social.map { network in
            switch network {
            case .twitter(let username), .github(let username): return username
            }
        }
        return str.joined(separator: ", ")
    }
}

import Foundation

enum SocialNetwork {
    case twitter(String)
    case github(String)
}

struct Author {
    let name: String
    let social: [SocialNetwork]
}

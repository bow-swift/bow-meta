//  Copyright © 2019 Bow Authors. All rights reserved.

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
    
    public struct NestedKeys1 {
        let nested1: Int
        let nested2: Int?
        private struct NestedKeys2 {
            let nested3: Bool
            let nested4: Bool?
            struct NestedKeys3 {
                let nested4: Bool
                let nested5: Bool?
            }
        }
        struct NestedKeys4 {
            let nested6: String
            let nested7: String?
        }
    }
}

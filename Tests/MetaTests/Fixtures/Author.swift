//  Copyright © 2019 Bow Authors. All rights reserved.

import Foundation
import Bow

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
        let nested8: NEA<String>
        private struct NestedKeys2 {
            let nested1: Bool
            let nested2: Bool?
            struct NestedKeys3 {
                let nested1: [Bool]
                let nested2: Bool?
            }
        }
        struct NestedKeys4 {
            let nested1: Int
            let nested2: Int? = 2 // immutable values may only be initialized once
            var nested22: Int? = 2
            let nested4: [String]? = []
            var nested44: [String]? = []
        }
    }
}

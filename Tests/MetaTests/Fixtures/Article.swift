//  Copyright © 2019 47Degrees. All rights reserved.

import Foundation

enum WrittingStyle {
    case expository
    case descriptive
    case persuasive
    case narrative
}

struct Article {
    let title: String
    let subtitle: String?
    public let state: PublicationState
    internal let author: Author
    private let style: WrittingStyle = .descriptive
    
    public enum NestedKeys1 {
        case nested1
        case nested2
        private enum NestedKeys2 {
            case nested1
            case nested2
            enum NestedKeys3 {
                case nested1
                case nested2
                case nested3
            }
        }
        enum NestedKeys4 {
            case nested1(nested: String)
            case nested2(nested: String)
        }
    }
}

enum PublicationState {
    case draft(date: Date, comments: String?)
    case published(comments: String?, date: Date)
    case deleted(date: Date, reason: String?, comments: String?)
}

struct Blog {
    let articles: [Article]
}

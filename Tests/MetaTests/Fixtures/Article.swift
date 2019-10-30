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
    let state: PublicationState
    let author: Author
    let style: WrittingStyle
    
    public enum NestedKeys1 {
        case nested1
        case nested2
        private enum NestedKeys2 {
            case nested3
            case nested4
            enum NestedKeys3 {
                case nested4
                case nested5
            }
        }
        enum NestedKeys4 {
            case nested6
            case nested7
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

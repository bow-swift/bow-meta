//  Copyright © 2019 47Degrees. All rights reserved.

import Foundation

enum WrittingStyle {
    case expository
    case descriptive
    case persuasive
    case narrative
}

enum PublicationState {
    case draft(date: Date, comments: String?)
    case published(comments: String?, date: Date)
    case deleted(date: Date, reason: String?, comments: String?)
}

struct Article {
    let title: String
    let subtitle: String?
    let state: PublicationState
    let author: Author
    let style: WrittingStyle
}

struct Blog {
    let articles: [Article]
}

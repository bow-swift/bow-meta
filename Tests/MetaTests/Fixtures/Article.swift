import Foundation

enum PublicationState {
    case draft
    case published(Date)
    case deleted(Date, reason: String?)
}

struct Article {
    let title: String
    let subtitle: String?
    let state: PublicationState
    let author: Author
}

struct Blog {
    let articles: [Article]
}

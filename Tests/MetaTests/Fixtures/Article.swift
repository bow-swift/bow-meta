import Foundation

enum PublicationState {
    case draft(date: Date)
    case published(date: Date)
    case deleted(date: Date, reason: String?)
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

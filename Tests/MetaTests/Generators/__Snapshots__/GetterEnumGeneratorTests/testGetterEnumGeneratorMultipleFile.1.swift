import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Article.swift

internal extension Article.NestedKeys1.NestedKeys4 {
    static var nestedGetter = Getter<Article.NestedKeys1.NestedKeys4, String> { state in
        switch state {
        case let .nested1(nested): return nested
        case let .nested2(nested): return nested
        }
    }
}

internal extension PublicationState {
    static var fieldsGetter = Getter<PublicationState, (Date, String?)> { state in
        switch state {
        case let .draft(date, comments): return (date, comments)
        case let .published(comments, date): return (date, comments)
        case let .deleted(date, _, comments): return (date, comments)
        }
    }
    
    static var fieldsNamedGetter = Getter<PublicationState, (date: Date, comments: String?)> { state in
        switch state {
        case let .draft(date, comments): return (date, comments)
        case let .published(comments, date): return (date, comments)
        case let .deleted(date, _, comments): return (date, comments)
        }
    }

    static let dateGetter: Getter<PublicationState, Date> = fieldsGetter + Tuple2._0
    static let commentsGetter: Getter<PublicationState, String?> = fieldsGetter + Tuple2._1
}


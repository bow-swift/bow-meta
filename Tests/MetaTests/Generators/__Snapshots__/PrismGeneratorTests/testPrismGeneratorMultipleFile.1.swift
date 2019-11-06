import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Author.swift

internal extension SocialNetwork {

    static var twitterPrism: Prism<SocialNetwork, String> {
        Prism(getOrModify: { state in
            guard case let .twitter(string0) = state else { return Bow.Either.left(state) }
            return Bow.Either.right(string0)
        }, reverseGet: SocialNetwork.twitter)
    }

    static var githubPrism: Prism<SocialNetwork, String> {
        Prism(getOrModify: { state in
            guard case let .github(string0) = state else { return Bow.Either.left(state) }
            return Bow.Either.right(string0)
        }, reverseGet: SocialNetwork.github)
    }
}


// MARK: - Generated from file Article.swift

internal extension WrittingStyle {
    
    static var expositoryPrism: Prism<WrittingStyle, Void> {
        Prism(getOrModify: { state in
            guard case .expository = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { WrittingStyle.expository })
    }
    
    static var descriptivePrism: Prism<WrittingStyle, Void> {
        Prism(getOrModify: { state in
            guard case .descriptive = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { WrittingStyle.descriptive })
    }
    
    static var persuasivePrism: Prism<WrittingStyle, Void> {
        Prism(getOrModify: { state in
            guard case .persuasive = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { WrittingStyle.persuasive })
    }
    
    static var narrativePrism: Prism<WrittingStyle, Void> {
        Prism(getOrModify: { state in
            guard case .narrative = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { WrittingStyle.narrative })
    }
}

internal extension Article.NestedKeys1 {
    
    static var nested1Prism: Prism<Article.NestedKeys1, Void> {
        Prism(getOrModify: { state in
            guard case .nested1 = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { Article.NestedKeys1.nested1 })
    }
    
    static var nested2Prism: Prism<Article.NestedKeys1, Void> {
        Prism(getOrModify: { state in
            guard case .nested2 = state else { return Bow.Either.left(state) }
            return Bow.Either.right(())
        }, reverseGet: { Article.NestedKeys1.nested2 })
    }
}

internal extension Article.NestedKeys1.NestedKeys4 {

    static var nested1Prism: Prism<Article.NestedKeys1.NestedKeys4, String> {
        Prism(getOrModify: { state in
            guard case let .nested1(string0) = state else { return Bow.Either.left(state) }
            return Bow.Either.right(string0)
        }, reverseGet: Article.NestedKeys1.NestedKeys4.nested1)
    }

    static var nested2Prism: Prism<Article.NestedKeys1.NestedKeys4, String> {
        Prism(getOrModify: { state in
            guard case let .nested2(string0) = state else { return Bow.Either.left(state) }
            return Bow.Either.right(string0)
        }, reverseGet: Article.NestedKeys1.NestedKeys4.nested2)
    }
}

internal extension PublicationState {

    static var draftPrism: Prism<PublicationState, (Date, String?)> {
        Prism(getOrModify: { state in
            guard case let .draft(date0, string1) = state else { return Bow.Either.left(state) }
            return Bow.Either.right((date0, string1))
        }, reverseGet: PublicationState.draft)
    }

    enum Draft {
        static let dateOptional: Optional<PublicationState, Date> = draftPrism + Tuple2._0
        static let commentsOptional: Optional<PublicationState, String?> = draftPrism + Tuple2._1
    }

    static var publishedPrism: Prism<PublicationState, (String?, Date)> {
        Prism(getOrModify: { state in
            guard case let .published(string0, date1) = state else { return Bow.Either.left(state) }
            return Bow.Either.right((string0, date1))
        }, reverseGet: PublicationState.published)
    }

    enum Published {
        static let commentsOptional: Optional<PublicationState, String?> = publishedPrism + Tuple2._0
        static let dateOptional: Optional<PublicationState, Date> = publishedPrism + Tuple2._1
    }

    static var deletedPrism: Prism<PublicationState, (Date, String?, String?)> {
        Prism(getOrModify: { state in
            guard case let .deleted(date0, string1, string2) = state else { return Bow.Either.left(state) }
            return Bow.Either.right((date0, string1, string2))
        }, reverseGet: PublicationState.deleted)
    }

    enum Deleted {
        static let dateOptional: Optional<PublicationState, Date> = deletedPrism + Tuple3._0
        static let reasonOptional: Optional<PublicationState, String?> = deletedPrism + Tuple3._1
        static let commentsOptional: Optional<PublicationState, String?> = deletedPrism + Tuple3._2
    }
}


import Bow
import BowOptics
import Foundation



// MARK: - Generated from file Author.swift

extension SocialNetwork {

    static var twitterPrism: Prism<SocialNetwork, String> {
        Prism(getOrModify: { state in
            guard case let .twitter(string0) = state else { return Either.left(state) }
            return Either.right(string0)
        }, reverseGet: SocialNetwork.twitter)
    }

    static var githubPrism: Prism<SocialNetwork, String> {
        Prism(getOrModify: { state in
            guard case let .github(string0) = state else { return Either.left(state) }
            return Either.right(string0)
        }, reverseGet: SocialNetwork.github)
    }
}


// MARK: - Generated from file Article.swift

extension PublicationState {
    
    static var draftPrism: Prism<PublicationState, Void> {
        Prism(getOrModify: { state in
            guard case .draft = state else { return Either.left(state) }
            return Either.right(())
        }, reverseGet: { PublicationState.draft })
    }

    static var publishedPrism: Prism<PublicationState, Date> {
        Prism(getOrModify: { state in
            guard case let .published(date0) = state else { return Either.left(state) }
            return Either.right(date0)
        }, reverseGet: PublicationState.published)
    }

    static var deletedPrism: Prism<PublicationState, (Date, String?)> {
        Prism(getOrModify: { state in
            guard case let .deleted(date0, string1) = state else { return Either.left(state) }
            return Either.right((date0, string1))
        }, reverseGet: PublicationState.deleted)
    }

    enum Deleted {
        static let dateOptional: Optional<PublicationState, Date> = deletedPrism + Tuple2._0
        static let reasonOptional: Optional<PublicationState, String?> = deletedPrism + Tuple2._1
    }
}


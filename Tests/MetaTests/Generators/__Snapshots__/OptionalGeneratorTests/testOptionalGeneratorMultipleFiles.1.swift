import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
    static var ctoOptional: Optional<Company, Employee> {
        Optional(set: { $0.copy(withCto: .some($1)) },
                 getOrModify: { company in
                     company.cto.fold(
                         { Either.left(company) },
                         Either.right)
                 })
    }
}



// MARK: - Generated from file Article.swift

extension Article {
    static var subtitleOptional: Optional<Article, String> {
        Optional(set: { $0.copy(withSubtitle: .some($1)) },
                 getOrModify: { article in
                     article.subtitle.toOption().fold(
                         { Either.left(article) },
                         Either.right)
                 })
    }
}


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


// MARK: - Generated from file Author.swift

extension Author.NestedKeys1 {
    static var nested2Optional: Optional<Author.NestedKeys1, Int> {
        Optional(set: { $0.copy(withNested2: .some($1)) },
                 getOrModify: { nestedkeys1 in
                     nestedkeys1.nested2.toOption().fold(
                         { Either.left(nestedkeys1) },
                         Either.right)
                 })
    }
}

extension Author.NestedKeys1.NestedKeys4 {
    static var nested7Optional: Optional<Author.NestedKeys1.NestedKeys4, String> {
        Optional(set: { $0.copy(withNested7: .some($1)) },
                 getOrModify: { nestedkeys4 in
                     nestedkeys4.nested7.toOption().fold(
                         { Either.left(nestedkeys4) },
                         Either.right)
                 })
    }

    static var nested8Optional: Optional<Author.NestedKeys1.NestedKeys4, [String]> {
        Optional(set: { $0.copy(withNested8: .some($1)) },
                 getOrModify: { nestedkeys4 in
                     nestedkeys4.nested8.toOption().fold(
                         { Either.left(nestedkeys4) },
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


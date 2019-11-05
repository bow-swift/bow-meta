import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {
    static var ctoOptional: Optional<Company, Employee> {
        Optional(set: { $0.copy(withCto: .some($1)) },
                 getOrModify: { company in
                     company.cto.fold(
                         { Bow.Either.left(company) },
                           Bow.Either.right)
                 })
    }
}


// MARK: - Generated from file Author.swift

internal extension Author.NestedKeys1 {
    static var nested2Optional: Optional<Author.NestedKeys1, Int> {
        Optional(set: { $0.copy(withNested2: .some($1)) },
                 getOrModify: { nestedkeys1 in
                     nestedkeys1.nested2.toOption().fold(
                         { Bow.Either.left(nestedkeys1) },
                           Bow.Either.right)
                 })
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {
    static var nested2Optional: Optional<Author.NestedKeys1.NestedKeys4, Int> {
        Optional(set: { $0.copy(withNested2: .some($1)) },
                 getOrModify: { nestedkeys4 in
                     nestedkeys4.nested2.toOption().fold(
                         { Bow.Either.left(nestedkeys4) },
                           Bow.Either.right)
                 })
    }

    static var nested4Optional: Optional<Author.NestedKeys1.NestedKeys4, [String]> {
        Optional(set: { $0.copy(withNested4: .some($1)) },
                 getOrModify: { nestedkeys4 in
                     nestedkeys4.nested4.toOption().fold(
                         { Bow.Either.left(nestedkeys4) },
                           Bow.Either.right)
                 })
    }
}


// MARK: - Generated from file Article.swift

internal extension Article {
    static var subtitleOptional: Optional<Article, String> {
        Optional(set: { $0.copy(withSubtitle: .some($1)) },
                 getOrModify: { article in
                     article.subtitle.toOption().fold(
                         { Bow.Either.left(article) },
                           Bow.Either.right)
                 })
    }
}


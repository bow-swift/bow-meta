import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {
    static var ceoLens: Lens<Company, Employee> {
        Lens(get: { $0.ceo },
             set: { $0.copy(withCeo: $1) })
    }

    static var ctoLens: Lens<Company, Option<Employee>> {
        Lens(get: { $0.cto },
             set: { $0.copy(withCto: $1) })
    }

    static var employeesLens: Lens<Company, ArrayK<Employee>> {
        Lens(get: { $0.employees },
             set: { $0.copy(withEmployees: $1) })
    }
}

internal extension Employee {
    static var nameLens: Lens<Employee, String> {
        Lens(get: { $0.name },
             set: { $0.copy(withName: $1) })
    }

    static var phoneNumbersLens: Lens<Employee, NEA<String>> {
        Lens(get: { $0.phoneNumbers },
             set: { $0.copy(withPhoneNumbers: $1) })
    }

    static var emailsLens: Lens<Employee, NonEmptyArray<String>> {
        Lens(get: { $0.emails },
             set: { $0.copy(withEmails: $1) })
    }
}


// MARK: - Generated from file Author.swift

internal extension Author {
    static var nameLens: Lens<Author, String> {
        Lens(get: { $0.name },
             set: { $0.copy(withName: $1) })
    }

    static var socialLens: Lens<Author, Array<SocialNetwork>> {
        Lens(get: { $0.social },
             set: { $0.copy(withSocial: $1) })
    }
}

internal extension Author.NestedKeys1 {
    static var nested1Lens: Lens<Author.NestedKeys1, Int> {
        Lens(get: { $0.nested1 },
             set: { $0.copy(withNested1: $1) })
    }

    static var nested2Lens: Lens<Author.NestedKeys1, Int?> {
        Lens(get: { $0.nested2 },
             set: { $0.copy(withNested2: $1) })
    }

    static var nested8Lens: Lens<Author.NestedKeys1, NEA<String>> {
        Lens(get: { $0.nested8 },
             set: { $0.copy(withNested8: $1) })
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {
    static var nested1Lens: Lens<Author.NestedKeys1.NestedKeys4, Int> {
        Lens(get: { $0.nested1 },
             set: { $0.copy(withNested1: $1) })
    }

    static var nested2Lens: Lens<Author.NestedKeys1.NestedKeys4, Int?> {
        Lens(get: { $0.nested2 },
             set: { $0.copy(withNested2: $1) })
    }

    static var nested4Lens: Lens<Author.NestedKeys1.NestedKeys4, [String]?> {
        Lens(get: { $0.nested4 },
             set: { $0.copy(withNested4: $1) })
    }
}


// MARK: - Generated from file Article.swift

internal extension Article {
    static var titleLens: Lens<Article, String> {
        Lens(get: { $0.title },
             set: { $0.copy(withTitle: $1) })
    }

    static var subtitleLens: Lens<Article, String?> {
        Lens(get: { $0.subtitle },
             set: { $0.copy(withSubtitle: $1) })
    }

    static var stateLens: Lens<Article, PublicationState> {
        Lens(get: { $0.state },
             set: { $0.copy(withState: $1) })
    }

    static var authorLens: Lens<Article, Author> {
        Lens(get: { $0.author },
             set: { $0.copy(withAuthor: $1) })
    }
}

internal extension Blog {
    static var articlesLens: Lens<Blog, [Article]> {
        Lens(get: { $0.articles },
             set: { $0.copy(withArticles: $1) })
    }
}


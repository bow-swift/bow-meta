import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
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

extension Employee {
    static var nameLens: Lens<Employee, String> {
        Lens(get: { $0.name },
             set: { $0.copy(withName: $1) })
    }

    static var phonesLens: Lens<Employee, NEA<String>> {
        Lens(get: { $0.phones },
             set: { $0.copy(withPhones: $1) })
    }

    static var emailsLens: Lens<Employee, NonEmptyArray<String>> {
        Lens(get: { $0.emails },
             set: { $0.copy(withEmails: $1) })
    }
}


// MARK: - Generated from file Author.swift

extension Author {
    static var nameLens: Lens<Author, String> {
        Lens(get: { $0.name },
             set: { $0.copy(withName: $1) })
    }

    static var socialLens: Lens<Author, Array<SocialNetwork>> {
        Lens(get: { $0.social },
             set: { $0.copy(withSocial: $1) })
    }
}


// MARK: - Generated from file Article.swift

extension Article {
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

    static var styleLens: Lens<Article, WrittingStyle> {
        Lens(get: { $0.style },
             set: { $0.copy(withStyle: $1) })
    }
}

extension Blog {
    static var articlesLens: Lens<Blog, [Article]> {
        Lens(get: { $0.articles },
             set: { $0.copy(withArticles: $1) })
    }
}


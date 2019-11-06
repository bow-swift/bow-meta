import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {
    static var iso: Iso<Company, (Employee, Option<Employee>, ArrayK<Employee>)> {
        Iso(get: { company in (company.ceo, company.cto, company.employees) }, reverseGet: Company.init(_withCeo:_withCto:_withEmployees:))
    }
}

internal extension Employee {
    static var iso: Iso<Employee, (String, NEA<String>, NonEmptyArray<String>)> {
        Iso(get: { employee in (employee.name, employee.phoneNumbers, employee.emails) }, reverseGet: Employee.init(_withName:_withPhoneNumbers:_withEmails:))
    }
}


// MARK: - Generated from file Author.swift

internal extension Author {
    static var iso: Iso<Author, (String, Array<SocialNetwork>)> {
        Iso(get: { author in (author.name, author.social) }, reverseGet: Author.init(_withName:_withSocial:))
    }
}

internal extension Author.NestedKeys1 {
    static var iso: Iso<Author.NestedKeys1, (Int, Int?, NEA<String>)> {
        Iso(get: { nestedkeys1 in (nestedkeys1.nested1, nestedkeys1.nested2, nestedkeys1.nested8) }, reverseGet: Author.NestedKeys1.init(_withNested1:_withNested2:_withNested8:))
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {
    static var iso: Iso<Author.NestedKeys1.NestedKeys4, (Int, Int?, [String]?)> {
        Iso(get: { nestedkeys4 in (nestedkeys4.nested1, nestedkeys4.nested22, nestedkeys4.nested44) }, reverseGet: Author.NestedKeys1.NestedKeys4.init(_withNested1:_withNested22:_withNested44:))
    }
}


// MARK: - Generated from file Article.swift

internal extension Article {
    static var iso: Iso<Article, (String, String?, PublicationState, Author)> {
        Iso(get: { article in (article.title, article.subtitle, article.state, article.author) }, reverseGet: Article.init(_withTitle:_withSubtitle:_withState:_withAuthor:))
    }
}

internal extension Blog {
    static var iso: Iso<Blog, ([Article])> {
        Iso(get: { blog in (blog.articles) }, reverseGet: Blog.init(_withArticles:))
    }
}


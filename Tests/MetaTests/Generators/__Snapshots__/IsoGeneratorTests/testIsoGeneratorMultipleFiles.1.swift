import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
    static var iso: Iso<Company, (Employee, Option<Employee>, ArrayK<Employee>)> {
        Iso(get: { company in (company.ceo, company.cto, company.employees) }, reverseGet: Company.init)
    }
}

extension Employee {
    static var iso: Iso<Employee, (String)> {
        Iso(get: { employee in (employee.name) }, reverseGet: Employee.init)
    }
}


// MARK: - Generated from file Author.swift

extension Author {
    static var iso: Iso<Author, (String, [SocialNetwork])> {
        Iso(get: { author in (author.name, author.social) }, reverseGet: Author.init)
    }
}


// MARK: - Generated from file Article.swift

extension Article {
    static var iso: Iso<Article, (String, String?, PublicationState, Author)> {
        Iso(get: { article in (article.title, article.subtitle, article.state, article.author) }, reverseGet: Article.init)
    }
}

extension Blog {
    static var iso: Iso<Blog, ([Article])> {
        Iso(get: { blog in (blog.articles) }, reverseGet: Blog.init)
    }
}

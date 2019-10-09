import Bow
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
    func copy(withCeo ceo: Employee? = nil,
			  withCto cto: Option<Employee>? = nil,
			  withEmployees employees: ArrayK<Employee>? = nil) -> Company {
        Company(ceo: ceo ?? self.ceo,
			cto: cto ?? self.cto,
			employees: employees ?? self.employees)
    }
}

extension Employee {
    func copy(withName name: String? = nil) -> Employee {
        Employee(name: name ?? self.name)
    }
}


// MARK: - Generated from file Author.swift

extension Author {
    func copy(withName name: String? = nil,
			  withSocial social: [SocialNetwork]? = nil) -> Author {
        Author(name: name ?? self.name,
			social: social ?? self.social)
    }
}


// MARK: - Generated from file Article.swift

extension Article {
    func copy(withTitle title: String? = nil,
			  withSubtitle subtitle: String?? = nil,
			  withState state: PublicationState? = nil,
			  withAuthor author: Author? = nil) -> Article {
        Article(title: title ?? self.title,
			subtitle: subtitle ?? self.subtitle,
			state: state ?? self.state,
			author: author ?? self.author)
    }
}

extension Blog {
    func copy(withArticles articles: [Article]? = nil) -> Blog {
        Blog(articles: articles ?? self.articles)
    }
}


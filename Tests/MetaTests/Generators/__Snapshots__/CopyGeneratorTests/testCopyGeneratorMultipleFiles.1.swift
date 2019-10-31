import Bow
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {
    func copy(withCeo ceo: Employee? = nil,
			  withCto cto: Option<Employee>? = nil,
			  withEmployees employees: ArrayK<Employee>? = nil) -> Company {
        Company(ceo: ceo ?? self.ceo,
			cto: cto ?? self.cto,
			employees: employees ?? self.employees)
    }
}

internal extension Employee {
    func copy(withName name: String? = nil,
			  withPhoneNumbers phoneNumbers: NEA<String>? = nil,
			  withEmails emails: NonEmptyArray<String>? = nil) -> Employee {
        Employee(name: name ?? self.name,
			phoneNumbers: phoneNumbers ?? self.phoneNumbers,
			emails: emails ?? self.emails)
    }
}


// MARK: - Generated from file Author.swift

internal extension Author {
    func copy(withName name: String? = nil,
			  withSocial social: Array<SocialNetwork>? = nil) -> Author {
        Author(name: name ?? self.name,
			social: social ?? self.social)
    }
}

internal extension Author.NestedKeys1 {
    func copy(withNested1 nested1: Int? = nil,
			  withNested2 nested2: Int?? = nil,
			  withNested8 nested8: NEA<String>? = nil) -> Author.NestedKeys1 {
        Author.NestedKeys1(nested1: nested1 ?? self.nested1,
			nested2: nested2 ?? self.nested2,
			nested8: nested8 ?? self.nested8)
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {
    func copy(withNested6 nested6: String? = nil,
			  withNested7 nested7: String?? = nil,
			  withNested8 nested8: [String]?? = nil) -> Author.NestedKeys1.NestedKeys4 {
        Author.NestedKeys1.NestedKeys4(nested6: nested6 ?? self.nested6,
			nested7: nested7 ?? self.nested7,
			nested8: nested8 ?? self.nested8)
    }
}


// MARK: - Generated from file Article.swift

internal extension Article {
    func copy(withTitle title: String? = nil,
			  withSubtitle subtitle: String?? = nil,
			  withState state: PublicationState? = nil,
			  withAuthor author: Author? = nil,
			  withStyle style: WrittingStyle? = nil) -> Article {
        Article(title: title ?? self.title,
			subtitle: subtitle ?? self.subtitle,
			state: state ?? self.state,
			author: author ?? self.author,
			style: style ?? self.style)
    }
}

internal extension Blog {
    func copy(withArticles articles: [Article]? = nil) -> Blog {
        Blog(articles: articles ?? self.articles)
    }
}


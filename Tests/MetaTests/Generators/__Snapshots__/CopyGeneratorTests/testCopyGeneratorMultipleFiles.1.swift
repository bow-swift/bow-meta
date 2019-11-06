import Bow
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {                            
    init(_withCeo ceo: Employee,
		 _withCto cto: Option<Employee>,
		 _withEmployees employees: ArrayK<Employee>) {
        self.ceo = ceo
		self.cto = cto
		self.employees = employees
    }
    
    func copy(withCeo ceo: Employee? = nil,
			  withCto cto: Option<Employee>? = nil,
			  withEmployees employees: ArrayK<Employee>? = nil) -> Company {
        Company(_withCeo: ceo ?? self.ceo,
			  _withCto: cto ?? self.cto,
			  _withEmployees: employees ?? self.employees)
    }
}

internal extension Employee {                            
    init(_withName name: String,
		 _withPhoneNumbers phoneNumbers: NEA<String>,
		 _withEmails emails: NonEmptyArray<String>) {
        self.name = name
		self.phoneNumbers = phoneNumbers
		self.emails = emails
    }
    
    func copy(withName name: String? = nil,
			  withPhoneNumbers phoneNumbers: NEA<String>? = nil,
			  withEmails emails: NonEmptyArray<String>? = nil) -> Employee {
        Employee(_withName: name ?? self.name,
			  _withPhoneNumbers: phoneNumbers ?? self.phoneNumbers,
			  _withEmails: emails ?? self.emails)
    }
}


// MARK: - Generated from file Author.swift

internal extension Author {                            
    init(_withName name: String,
		 _withSocial social: Array<SocialNetwork>) {
        self.name = name
		self.social = social
    }
    
    func copy(withName name: String? = nil,
			  withSocial social: Array<SocialNetwork>? = nil) -> Author {
        Author(_withName: name ?? self.name,
			  _withSocial: social ?? self.social)
    }
}

internal extension Author.NestedKeys1 {                            
    init(_withNested1 nested1: Int,
		 _withNested2 nested2: Int?,
		 _withNested8 nested8: NEA<String>) {
        self.nested1 = nested1
		self.nested2 = nested2
		self.nested8 = nested8
    }
    
    func copy(withNested1 nested1: Int? = nil,
			  withNested2 nested2: Int?? = nil,
			  withNested8 nested8: NEA<String>? = nil) -> Author.NestedKeys1 {
        Author.NestedKeys1(_withNested1: nested1 ?? self.nested1,
			  _withNested2: nested2 ?? self.nested2,
			  _withNested8: nested8 ?? self.nested8)
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {                            
    init(_withNested1 nested1: Int,
		 _withNested22 nested22: Int?,
		 _withNested44 nested44: [String]?) {
        self.nested1 = nested1
		self.nested22 = nested22
		self.nested44 = nested44
    }
    
    func copy(withNested1 nested1: Int? = nil,
			  withNested22 nested22: Int?? = nil,
			  withNested44 nested44: [String]?? = nil) -> Author.NestedKeys1.NestedKeys4 {
        Author.NestedKeys1.NestedKeys4(_withNested1: nested1 ?? self.nested1,
			  _withNested22: nested22 ?? self.nested22,
			  _withNested44: nested44 ?? self.nested44)
    }
}


// MARK: - Generated from file Article.swift

internal extension Article {                            
    init(_withTitle title: String,
		 _withSubtitle subtitle: String?,
		 _withState state: PublicationState,
		 _withAuthor author: Author) {
        self.title = title
		self.subtitle = subtitle
		self.state = state
		self.author = author
    }
    
    func copy(withTitle title: String? = nil,
			  withSubtitle subtitle: String?? = nil,
			  withState state: PublicationState? = nil,
			  withAuthor author: Author? = nil) -> Article {
        Article(_withTitle: title ?? self.title,
			  _withSubtitle: subtitle ?? self.subtitle,
			  _withState: state ?? self.state,
			  _withAuthor: author ?? self.author)
    }
}

internal extension Blog {                            
    init(_withArticles articles: [Article]) {
        self.articles = articles
    }
    
    func copy(withArticles articles: [Article]? = nil) -> Blog {
        Blog(_withArticles: articles ?? self.articles)
    }
}


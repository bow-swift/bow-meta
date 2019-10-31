import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
    static var employeesTraversal: Traversal<Company, Employee> {
        employeesLens + ArrayK<Employee>.traversal
    }
}

extension Employee {
    static var phoneNumbersTraversal: Traversal<Employee, String> {
        phoneNumbersLens + NEA<String>.traversal
    }

    static var emailsTraversal: Traversal<Employee, String> {
        emailsLens + NonEmptyArray<String>.traversal
    }
}


// MARK: - Generated from file Author.swift

extension Author {
    static var socialTraversal: Traversal<Author, SocialNetwork> {
        socialLens + Array<SocialNetwork>.traversal
    }
}

extension Author.NestedKeys1 {
    static var nested8Traversal: Traversal<Author.NestedKeys1, String> {
        nested8Lens + NEA<String>.traversal
    }
}

extension Author.NestedKeys1.NestedKeys4 {
    static var nested8Traversal: Traversal<Author.NestedKeys1.NestedKeys4, String> {
        nested8Optional + [String].traversal
    }
}


// MARK: - Generated from file Article.swift

extension Blog {
    static var articlesTraversal: Traversal<Blog, Article> {
        articlesLens + [Article].traversal
    }
}


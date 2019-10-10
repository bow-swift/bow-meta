import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

extension Company {
    static var employeesTraversal: Traversal<Company, Employee> {
        employeesLens + ArrayK<Employee>.traversal
    }
}


// MARK: - Generated from file Author.swift

extension Author {
    static var socialTraversal: Traversal<Author, SocialNetwork> {
        socialLens + [SocialNetwork].traversal
    }
}


// MARK: - Generated from file Article.swift

extension Blog {
    static var articlesTraversal: Traversal<Blog, Article> {
        articlesLens + [Article].traversal
    }
}


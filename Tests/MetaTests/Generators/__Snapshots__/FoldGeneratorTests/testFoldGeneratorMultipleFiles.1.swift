import Bow
import BowOptics
import Foundation


// MARK: - Generated from file Company.swift

internal extension Company {
    static var employeesFold: Fold<Company, Employee> {
        employeesLens + ArrayK<Employee>.fold
    }
}

internal extension Employee {
    static var phoneNumbersFold: Fold<Employee, String> {
        phoneNumbersLens + NEA<String>.fold
    }

    static var emailsFold: Fold<Employee, String> {
        emailsLens + NonEmptyArray<String>.fold
    }
}


// MARK: - Generated from file Author.swift

internal extension Author {
    static var socialFold: Fold<Author, SocialNetwork> {
        socialLens + Array<SocialNetwork>.fold
    }
}

internal extension Author.NestedKeys1 {
    static var nested8Fold: Fold<Author.NestedKeys1, String> {
        nested8Lens + NEA<String>.fold
    }
}

internal extension Author.NestedKeys1.NestedKeys4 {
    static var nested44Fold: Fold<Author.NestedKeys1.NestedKeys4, String> {
        nested44Optional + [String].fold
    }
}


// MARK: - Generated from file Article.swift

internal extension Blog {
    static var articlesFold: Fold<Blog, Article> {
        articlesLens + [Article].fold
    }
}


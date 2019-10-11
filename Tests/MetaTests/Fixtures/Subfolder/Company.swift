import Bow

struct Company {
    let ceo: Employee
    let cto: Option<Employee>
    let employees: ArrayK<Employee>
}

struct Employee {
    let name: String
    let phones: NEA<String>
    let emails: NonEmptyArray<String>
}

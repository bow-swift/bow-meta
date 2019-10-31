extension Array where Element == Field {
    var optionalsType: [Field] { filter { field in field.type.isOptionalType } }
    var arraysType: [Field] { filter { field in !field.type.isOptionalType && field.type.isArrayType } }
}

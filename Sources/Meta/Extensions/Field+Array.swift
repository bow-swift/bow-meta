extension Array where Element == Field {
    var optionals: [Field] { filter { field in field.type.isOptionalType } }
    var arrays: [Field] { filter { field in field.type.isArrayType } }
}

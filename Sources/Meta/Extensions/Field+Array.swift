extension Array where Element == Field {
    var optionals: [Field] { filter { field in field.type.isOptionalType } }
    var arrays: [Field] { filter { field in field.type.isArrayType } }
    var optionalsWithArray: [Field] { filter { field in field.type.nonOptional.isArrayType } }
}
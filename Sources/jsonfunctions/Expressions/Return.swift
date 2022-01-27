//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct Return: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)

        guard let value = result.array?.first else {
            throw ParseError.InvalidParameters("Return: Expected array with one element")
        }

        throw JsonFunctionsError.returnJSON(value)
    }

}

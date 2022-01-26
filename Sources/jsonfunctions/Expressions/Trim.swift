//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct Trim: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)

        guard let value = result.array?.first else {
            throw ParseError.InvalidParameters("Trim: Expected one parameter")
        }

        let trimmedDescription = try value.innerDescription().trimmingCharacters(in: .whitespacesAndNewlines)

        return JSON(trimmedDescription)
    }

}

//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct ToLowerCase: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)

        guard let value = result.array?.first else {
            throw ParseError.InvalidParameters("ToLowerCase: Expected one parameter")
        }

        let lowercasedDescription = try value.innerDescription().lowercased()

        return JSON(lowercasedDescription)
    }

}

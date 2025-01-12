//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct Concatenate: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)

        guard let values = result.array else {
            throw ParseError.InvalidParameters("Concatenate: Expected array as parameter")
        }

        let joinedDescription = try values.map { try $0.innerDescription() }.joined()

        return JSON(joinedDescription)
    }

}

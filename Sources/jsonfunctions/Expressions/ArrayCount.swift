//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct ArrayCount: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
              case let .Array(dataArray) = try array.expressions[0].eval(with: &data)
                else {
            return JSON(0)
        }

        return JSON(dataArray.count)
    }

}

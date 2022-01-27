//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct Declare: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let arrayExpression = expression as? ArrayOfExpressions,
              let identifierExpression = arrayExpression.expressions[safe: 0],
              let valueExpression = arrayExpression.expressions[safe: 1]
        else {
            throw ParseError.InvalidParameters("Declare: Expected two parameters")
        }

        let identifierResult = try identifierExpression.eval(with: &data)

        guard let identifier = identifierResult.string else {
            throw ParseError.InvalidParameters("Declare: Expected string identifier")
        }

        let valueResult = try valueExpression.eval(with: &data)

        data[identifier] = valueResult

        return .Null
    }

}

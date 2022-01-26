//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct Evaluate: Expression {

    let expression: Expression

    let registeredFunctions: [String: JsonFunctionDefinition]

    func eval(with data: inout JSON) throws -> JSON {
        guard let arrayExpression = expression as? ArrayOfExpressions,
              let expressionExpression = arrayExpression.expressions[safe: 0],
              let parametersExpression = arrayExpression.expressions[safe: 1]
        else {
            throw ParseError.InvalidParameters("Evaluate: Expected two parameters")
        }

        let expressionResult = try expressionExpression.eval(with: &data)
        let expression = try Parser(
            json: expressionResult,
            registeredFunctions: registeredFunctions
        ).parse()

        let parametersResult = try parametersExpression.eval(with: &data)

        return try expression.eval(with: parametersResult)
    }

}

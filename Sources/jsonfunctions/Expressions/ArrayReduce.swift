//
// json-functions-swift
//
// Parts of this file are copied from file
// https://github.com/eu-digital-green-certificates/json-logic-swift/blob/master/Sources/jsonlogic/Parser.swift
// in forked Repository
// https://github.com/eu-digital-green-certificates/json-logic-swift
//
//  Parser.swift
//  jsonlogic
//
//  Created by Christos Koninis on 16/06/2018.
//  Licensed under MIT
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct ArrayReduce: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
              array.expressions.count >= 3,
              let intoValue: JSON = try? array.expressions[2].eval(with: &data)
                else {
            return .Null
        }

        guard case let .Array(dataArray) = try array.expressions[0].eval(with: &data) else {
            return intoValue
        }

        var scopedData = data
        let reduceOperation = array.expressions[1]

        return try dataArray
            .enumerated()
            .reduce(into: intoValue) { (result: inout JSON, value: (Int, JSON)) in
                scopedData["data"] = data
                scopedData["accumulator"] = result
                scopedData["current"] = value.1
                scopedData["__index__"] = JSON(value.0)
                result = try reduceOperation.eval(with: &scopedData)
            }
    }

}

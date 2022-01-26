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

struct ArrayFilter: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
            array.expressions.count >= 2,
            case let .Array(dataArray) = try array.expressions[0].eval(with: &data)
            else {
                return .Array([])
        }

        let filterOperation = array.expressions[1]

        if let elementKeyJSON = try array.expressions[safe: 2]?.eval(with: &data), data.type == .object {
            guard let elementKey = elementKeyJSON.string else {
                throw ParseError.InvalidParameters("ArrayFilter: Expected key to be string")
            }

            let filteredArray = try dataArray.filter {
                data[elementKey] = $0
                return try filterOperation.eval(with: &data).truthy()
            }

            return JSON(filteredArray)
        } else {
            let filteredArray = try dataArray.filter {
                try filterOperation.eval(with: $0).truthy()
            }

            return JSON(filteredArray)
        }
    }
    
}

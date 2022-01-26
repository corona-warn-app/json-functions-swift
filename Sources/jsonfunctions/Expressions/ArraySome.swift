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

struct ArraySome: Expression {
    
    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
              array.expressions.count >= 2,
              case let .Array(dataArray) = try array.expressions[0].eval(with: &data)
                else {
            return false
        }

        let operation = array.expressions[1]

        if let elementKey = try array.expressions[safe: 2]?.eval(with: &data).string, var dataDictionary = data.dictionary {
            let someSatisfy = try dataArray.contains {
                dataDictionary[elementKey] = $0
                var dataDictionaryJSON = JSON(dataDictionary)
                return try operation.eval(with: &dataDictionaryJSON).truthy()
            }

            return JSON(someSatisfy)
        } else {
            let someSatisfy = try dataArray.contains {
                var element = $0
                return try operation.eval(with: &element).truthy()
            }

            return JSON(someSatisfy)
        }
    }

}

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

struct ArrayNone: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
            array.expressions.count >= 2,
            case let .Array(dataArray) = try array.expressions[0].eval(with: &data)
            else {
                return true
        }
        let operation = array.expressions[1]

        return .Bool(try dataArray.reduce(into: true) {
            $0 = try $0 && !operation.eval(with: $1).truthy()
        })
    }
    
}

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

struct ArrayMerge: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let dataArray = try expression.eval(with: &data)

        return .Array(recursiveFlattenArray(dataArray))
    }

    func recursiveFlattenArray(_ json: JSON) -> [JSON] {
        switch json {
        case let .Array(array):
            return array.flatMap({ recursiveFlattenArray($0) })
        default:
            return [json]
        }
    }
    
}

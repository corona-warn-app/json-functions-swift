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

struct Multiply: Expression {

    let arg: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let total = JSON(1)
        let result = try arg.eval(with: &data)

        switch result {
        case let .Array(array):
            return array.reduce(total) { $0 * ($1.toNumber()) }
        default:
            return result.toNumber()
        }
    }
    
}

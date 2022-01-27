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

struct DoubleNegation: Expression {

    let arg: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let data = try arg.eval(with: data)
        guard case let JSON.Array(array) = data else {
            return JSON.Bool(data.truthy())
        }
        if let firstItem = array.first {
            return JSON.Bool(firstItem.truthy())
        }
        return JSON.Bool(false)
    }
    
}

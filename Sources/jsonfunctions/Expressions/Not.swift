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

struct Not: Expression {

    let lhs: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let lhsBool = try lhs.eval(with: &data)
        if let array = lhsBool.array
        {
            if(array.count == 0)
            {
                return .Bool(!lhsBool.truthy())
            }
            else
            {
               return .Bool(!array[0].truthy())
            }
        }

        return .Bool(!lhsBool.truthy())
    }
    
}

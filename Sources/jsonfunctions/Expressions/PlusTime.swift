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

struct PlusTime: Expression {

    let expression: Expression
    
    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)
        
        if let arr = result.array,
           let time = arr[0].date,
           let amount = arr[1].int,
           let unit = arr[2].string
           {
            return time.addTime(Int(amount), as: unit)
        }

        return .Null
    }

}

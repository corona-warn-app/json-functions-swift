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

struct Min: Expression {

    let arg: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard case let .Array(array) = try arg.eval(with: &data) else {
            return .Null
        }

        return array.min() ?? .Null
    }

}

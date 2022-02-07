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

struct DateComparison: Expression {

    let arg: Expression
    let operation: (JSON, JSON) -> Bool
    let defaultValue: Bool

    func eval(with data: inout JSON) throws -> JSON {
        let result = try arg.eval(with: &data)

        guard case let .Array(array) = result else {
            return JSON(defaultValue)
        }

        if array.count == 2, case .Date(_) = array[0], case .Date(_) = array[1] {
            return .Bool(operation(array[0], array[1]))
        } else if array.count == 3, case .Date(_) = array[0], case .Date(_) = array[1], case .Date(_) = array[2] {
            return .Bool(operation(array[0], array[1]) && operation(array[1], array[2]))
        } else {
            return JSON(defaultValue)
        }
    }

}

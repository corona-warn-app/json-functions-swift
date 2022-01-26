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

struct MissingSome: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let arg = try expression.eval(with: &data)

        guard case let JSON.Array(array) = arg,
              array.count >= 2,
              case let .Int(minRequired) = array[0],
              case let .Array(keys) = array[1] else {
            return .Null
        }

        let foundKeys = keys.filter({ valueForKey($0.string, in: data) != .Null })
        let missingkeys = { keys.filter({ !foundKeys.contains($0) }) }

        return .Array(foundKeys.count < minRequired ? missingkeys() : [])
    }

    func valueForKey(_ key: String?, in data: JSON?) -> JSON? {
        guard let key = key else { return .Null }
        let variablePathParts = key.split(separator: ".").map({ String($0) })
        var partialResult: JSON? = data
        for key in variablePathParts {
            partialResult = partialResult?[key]
        }

        guard let result = partialResult else {
            return .Null
        }

        if case JSON.Error(_) = result {
            return .Null
        }

        return result
    }

}

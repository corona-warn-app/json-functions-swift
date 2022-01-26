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

struct Cat: Expression {

    let arg: Expression

    func eval(with data: inout JSON) throws -> JSON {
        var result = ""

        let evaluation = try arg.eval(with: &data)
        switch evaluation {
        case let .Array(array):
            result = array.reduce(into: "") { (result, element) in
                result.append(stringFromJSON(element))
            }
        default:
            result = stringFromJSON(evaluation)
        }

        return JSON(result)
    }

    private func stringFromJSON(_ json: JSON) -> String {
        switch json {
        case let .Bool(bool):
            return "\(bool)"
        case let .Double(number):
            return "\(number)"
        case let .Int(number):
            return "\(number)"
        case let .String(string):
            return string
        case let .Array(array):
            return array.map({stringFromJSON($0)}).joined(separator: ",")
        case .Dictionary:
            return ""
        default:
            return ""
        }
    }

}

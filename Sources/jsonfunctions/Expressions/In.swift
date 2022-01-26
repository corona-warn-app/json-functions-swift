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

//swiftlint:disable:next type_name
struct In: Expression {

    let stringExpression: Expression
    let collectionExpression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        if let stringToSearchIn = try collectionExpression.eval(with: &data).string {
            guard let stringToFind = try stringExpression.eval(with: &data).string
                else {
                return false;
            }
            return JSON(stringToSearchIn.contains(stringToFind))
        } else if let arrayToSearchIn = try collectionExpression.eval(with: &data).array {
            let itemToFind = try stringExpression.eval(with: &data)
            return JSON(arrayToSearchIn.contains(itemToFind))
        }
        return false
    }
    
}

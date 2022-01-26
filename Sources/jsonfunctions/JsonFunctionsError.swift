//
// json-functions-swift
//
// Parts of this file are copied from file
// https://github.com/eu-digital-green-certificates/json-logic-swift/blob/master/Sources/jsonlogic/JsonLogic.swift
// in forked Repository
// https://github.com/eu-digital-green-certificates/json-logic-swift
//
//  JsonLogic.swift
//  jsonlogic
//
//  Created by Christos Koninis on 06/06/2018.
//  Licensed under MIT
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

///  Errors that can be thrown from JsonFunctions methods
public enum JsonFunctionsError: Error, Equatable {

    public static func == (lhs: JsonFunctionsError, rhs: JsonFunctionsError) -> Bool {
        switch (lhs, rhs) {
        case let (canNotParseJSONData(ltype), canNotParseJSONData(rtype)):
                return ltype == rtype
        case let (canNotConvertResultToType(ltype), canNotConvertResultToType(rtype)):
                return ltype == rtype
        case let (canNotParseJSONRule(ltype), canNotParseJSONRule(rtype)):
                return ltype == rtype
        case (.noSuchFunction, .noSuchFunction):
            return true
        default:
            return false
        }
    }

    /// Invalid json data was passed
    case canNotParseJSONData(String)

    /// Invalid json rule was passed
    case canNotParseJSONRule(String)

    /// Could not convert the result from applying the rule to the expected type
    case canNotConvertResultToType(Any.Type)

    case noSuchFunction

    case returnJSON(JSON)

}

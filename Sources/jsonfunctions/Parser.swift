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

class Parser {

    private let json: JSON
    private let customOperators: [String: (JSON?) -> JSON]
    private let registeredFunctions: [String: JsonFunctionDefinition]

    init(
        json: JSON,
        customOperators: [String: (JSON?) -> JSON]? = nil,
        registeredFunctions: [String: JsonFunctionDefinition]
    ) {
        self.json = json
        self.customOperators = customOperators ?? [:]
        self.registeredFunctions = registeredFunctions
    }

    func parse() throws -> Expression {
        return try self.parse(json: self.json)
    }

    func parse(json: JSON) throws -> Expression {
        switch json {
        case .Error:
            throw ParseError.GenericError("Error parsing json '\(json)'")
        case .Null:
            return SingleValueExpression(json: json)
        case .Bool:
            return SingleValueExpression(json: json)
        case .Int:
            return SingleValueExpression(json: json)
        case .Double:
            return SingleValueExpression(json: json)
        case .String:
            return SingleValueExpression(json: json)
        case .Date:
            return SingleValueExpression(json: json)
        case let .Array(array):
            var arrayOfExpressions: [Expression] = []

            for element in array {
                arrayOfExpressions.append(try parse(json: element))
            }

            return ArrayOfExpressions(expressions: arrayOfExpressions)
        case let .Dictionary(object):
            if object.count == 0 {
                return ArrayOfExpressions(expressions: [])
            } else if object.count == 1, let key = object.keys.first, let value = object[key] {
                return try parseExpressionWithKeyword(key, value: value)
            } else {
                return SingleValueExpression(json: json)
            }
        }
    }

    //swiftlint:disable:next function_body_length cyclomatic_complexity
    func parseExpressionWithKeyword(_ key: String, value: JSON) throws -> Expression {
        switch key {
        case "var":
            return Var(expression: try self.parse(json: value))
        case "===":
            return StrictEquals(
                lhs: try self.parse(json: value[0]),
                rhs: try self.parse(json: value[1])
            )
        case "!==":
            return Not(
                lhs: StrictEquals(
                    lhs: try parse(json: value[0]),
                    rhs: try parse(json: value[1])
                )
            )
        case "==":
            return Equals(
                lhs: try self.parse(json: value[0]),
                rhs: try self.parse(json: value[1])
            )
        case "!=":
            return Not(
                lhs: Equals(
                    lhs: try self.parse(json: value[0]),
                    rhs: try self.parse(json: value[1])
                )
            )
        case "!":
            return Not(lhs: try self.parse(json: value))
        case "+":
            return Add(arg: try self.parse(json: value))
        case "-":
            return Subtract(arg: try self.parse(json: value))
        case "*":
            return Multiply(arg: try self.parse(json: value))
        case "/":
            return Divide(arg: try self.parse(json: value))
        case "%":
            return Modulo(arg: try self.parse(json: value))
        case ">":
            return Comparison(arg: try self.parse(json: value), operation: >)
        case "<":
            return Comparison(arg: try self.parse(json: value), operation: <)
        case ">=":
            return Comparison(arg: try self.parse(json: value), operation: >=)
        case "<=":
            return Comparison(arg: try self.parse(json: value), operation: <=)
        case "after":
            return DateComparison(arg: try self.parse(json: value), operation: >, defaultValue: false)
        case "before":
            return DateComparison(arg: try self.parse(json: value), operation: <, defaultValue: false)
        case "not-before":
            return DateComparison(arg: try self.parse(json: value), operation: >=, defaultValue: true)
        case "not-after":
            return DateComparison(arg: try self.parse(json: value), operation: <=, defaultValue: true)
        case "if", "?:":
            guard let array = try self.parse(json: value) as? ArrayOfExpressions else {
                throw ParseError.GenericError("\(key) statement be followed by an array")
            }

            return If(arg: array)
        case "and", "or":
            guard let array = try self.parse(json: value) as? ArrayOfExpressions else {
                throw ParseError.GenericError("\(key) statement be followed by an array")
            }

            return LogicalAndOr(isAnd: key == "and", arg: array)
        case "!!":
            return DoubleNegation(arg: try self.parse(json: value))
        case "max":
             return Max(arg: try self.parse(json: value))
        case "min":
            return Min(arg: try self.parse(json: value))
        case "substr":
            guard let array = try self.parse(json: value) as? ArrayOfExpressions else {
                throw ParseError.GenericError("\(key) statement be followed by an array")
            }

            if array.expressions.count == 3 {
                return Substr(
                    stringExpression: array.expressions[0],
                    startExpression: array.expressions[1],
                    lengthExpression: array.expressions[2]
                )
            }

            return Substr(
                stringExpression: array.expressions[0],
                startExpression: array.expressions[1],
                lengthExpression: nil
            )
        case "in":
            return In(
                stringExpression: try self.parse(json: value[0]),
                collectionExpression: try self.parse(json: value[1])
            )
        case "cat":
            return Cat(arg: try self.parse(json: value))
        case "missing":
            return Missing(expression: try self.parse(json: value))
        case "missing_some":
            return MissingSome(expression: try self.parse(json: value))
        case "map":
            return ArrayMap(expression: try self.parse(json: value))
        case "reduce":
            return ArrayReduce(expression: try self.parse(json: value))
        case "filter":
            return ArrayFilter(expression: try self.parse(json: value))
        case "none":
            return ArrayNone(expression: try self.parse(json: value))
        case "all":
            return ArrayAll(expression: try self.parse(json: value))
        case "some":
            return ArraySome(expression: try self.parse(json: value))
        case "merge":
            return ArrayMerge(expression: try self.parse(json: value))
        case "count":
            return ArrayCount(expression: try self.parse(json: value))
        case "find":
            return ArrayFind(expression: try self.parse(json: value))
        case "push":
            return ArrayPush(expression: try self.parse(json: value))
        case "sort":
            return ArraySort(expression: try self.parse(json: value))
        case "log":
            return Log(expression: try self.parse(json: value))
        case "plusTime":
            return PlusTime(expression: try self.parse(json: value))
        case "minusTime":
            return MinusTime(expression: try self.parse(json: value))
        case "diffTime":
            return DiffTime(expression: try self.parse(json: value))
        case "extractFromUVCI":
            return ExtractFromUVCI(expression: try self.parse(json: value))
        case "concatenate":
            return Concatenate(expression: try self.parse(json: value))
        case "replaceAll":
            return ReplaceAll(expression: try self.parse(json: value))
        case "split":
            return Split(expression: try self.parse(json: value))
        case "toLowerCase":
            return ToLowerCase(expression: try self.parse(json: value))
        case "toUpperCase":
            return ToUpperCase(expression: try self.parse(json: value))
        case "trim":
            return Trim(expression: try self.parse(json: value))
        case "script":
            return Script(expression: try self.parse(json: value))
        case "declare":
            return Declare(expression: try self.parse(json: value))
        case "evaluate":
            return Evaluate(
                expression: try self.parse(json: value),
                registeredFunctions: registeredFunctions
            )
        case "return":
            return Return(expression: try self.parse(json: value))
        case "init":
            return Init(expression: try self.parse(json: value))
        case "spread":
            return Spread(expression: try self.parse(json: value))
        case "call":
            return Call(
                json: value,
                registeredFunctions: registeredFunctions
            )
        case "assign":
            return Assign(expression: try self.parse(json: value))
        default:
            if let customOperation = self.customOperators[key] {
                return CustomExpression(
                    expression: try self.parse(json: value),
                    customOperator: customOperation
                )
            } else {
                throw ParseError.UnimplementedExpressionFor(key)
            }
        }
    }

}

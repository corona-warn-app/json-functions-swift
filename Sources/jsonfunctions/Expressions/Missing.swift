//
// json-functions-swift
//

import Foundation

struct Missing: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let keys = try evaluateVarPathFromData(data)
        let missingKeys = keys.filter({ valueForKey($0, in: data) == .Null })

        return .Array(missingKeys.map { .String($0) })
    }

    func valueForKey(_ key: String, in data: JSON) -> JSON {
        let variablePathParts = key.split(separator: ".").map({String($0)})
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

    func evaluateVarPathFromData(_ data: JSON) throws -> [String] {
        let variablePathAsJSON = try self.expression.eval(with: data)

        switch variablePathAsJSON {
        case let .String(string):
            return [string]
        case let .Array(array):
            return array.compactMap { $0.string }
        default:
            return []
        }
    }

}

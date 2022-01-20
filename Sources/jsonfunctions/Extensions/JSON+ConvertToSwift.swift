//
// json-functions-swift
//

import Foundation
import JSON

extension JSON {

    func convertToSwiftTypes(dateToString: Bool = false) throws -> Any? {
        switch self {
        case .Error:
            throw JsonFunctionsError.canNotParseJSONData("\(self)")
        case .Null:
            return Optional<Any>.none
        case .Bool:
            return self.bool
        case .Int:
            return Swift.Int(self.int!)
        case .Double:
            return self.double
        case .String:
            return self.string
        case let .Date(date):
            if dateToString {
                return date.fullFormatted
            } else {
                return date
            }
        case let .Array(array):
            return try array.map { try $0.convertToSwiftTypes(dateToString: dateToString) }
        case let .Dictionary(dict):
            return try dict.mapValues {
                try $0.convertToSwiftTypes(dateToString: dateToString)
            }
        }
    }

    func decoded<T: Decodable>(to: T.Type) throws -> T {
        let convertedToSwiftStandardType = try convertToSwiftTypes()

        let jsonData = try JSONSerialization.data(withJSONObject: convertedToSwiftStandardType as Any, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: jsonData)
    }

    func jsonString() throws -> String? {
        let convertedToSwiftStandardType = try convertToSwiftTypes(dateToString: true)

        let jsonData: Data
        if #available(iOS 13.0, macOS 10.15, *) {
            jsonData = try JSONSerialization.data(withJSONObject: convertedToSwiftStandardType as Any, options: [.fragmentsAllowed, .sortedKeys, .withoutEscapingSlashes])
        } else {
            jsonData = try JSONSerialization.data(withJSONObject: convertedToSwiftStandardType as Any, options: [.fragmentsAllowed, .sortedKeys])
        }
        return Swift.String(data: jsonData, encoding: .utf8)
    }

}

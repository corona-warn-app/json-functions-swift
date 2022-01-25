//
// json-functions-swift
//

import Foundation

extension JSON {

    func convertToSwiftTypes(dateToString: Bool = false) throws -> Any? {
        switch self {
        case let .Error(error):
            throw JsonFunctionsError.canNotParseJSONData("\(error)")
        case .Null:
            return Optional<Any>.none
        case let .Bool(bool):
            return bool
        case let .Int(int):
            return Swift.Int(int)
        case let .Double(double):
            return double
        case let .String(string):
            return string
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

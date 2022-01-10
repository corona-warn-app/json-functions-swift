//
// json-functions-swift
//

import Foundation
import JSON

/**
    A shortcut method to parse and apply a json logic rule.

    If you need to apply the same rule to multiple json data, it is more efficient to
    instantiate a `JsonLogic` class that will cache and reuse the parsed rule.
*/
public func applyRule<T>(_ jsonRule: String, to jsonDataOrNil: String? = nil) throws -> T {
    return try JsonLogic(jsonRule).applyRule(to: jsonDataOrNil)
}

public func applyRule<T>(_ jsonRule: JSON, to jsonDataOrNil: String? = nil) throws -> T {
    return try JsonLogic(jsonRule).applyRule(to: jsonDataOrNil)
}
public func applyRule<T>(_ jsonRule: JSON, to jsonOrNil: JSON? = nil) throws -> T {
    return try JsonLogic(jsonRule).applyRule(to: jsonOrNil)
}

public func applyRule<T>(_ jsonRule: JSON, to jsonDataOrNil: String? = nil, customOperators: [String: (JSON?) -> JSON]?) throws -> T {
    return try JsonLogic(jsonRule, customOperators: customOperators).applyRule(to: jsonDataOrNil)
}

public func applyRule<T>(_ jsonRule: JSON, to jsonOrNil: JSON? = nil, customOperators: [String: (JSON?) -> JSON]?) throws -> T {
    return try JsonLogic(jsonRule, customOperators: customOperators).applyRule(to: jsonOrNil)
}

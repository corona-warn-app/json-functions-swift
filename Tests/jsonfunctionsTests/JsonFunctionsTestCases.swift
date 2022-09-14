//
// jsonfunctionsTests
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import XCTest
import AnyCodable
@testable import jsonfunctions

struct JsonFunctionsTestCases: Decodable {

    let testCases: [JsonFunctionsTestCase]
    let commonFunctions: [JsonFunctionDescriptor]?

}

struct JsonFunctionsTestCase: Decodable {

    let title: String
    let functions: [JsonFunctionDescriptor]?
    let evaluateFunction: JsonFunctionCall?
    let logic: AnyDecodable?
    let data: AnyDecodable?
    let exp: AnyDecodable?
    let `throws`: Bool?

}

struct JsonFunctionCall: Decodable {

    let name: String
    let parameters: [String: AnyDecodable]

}

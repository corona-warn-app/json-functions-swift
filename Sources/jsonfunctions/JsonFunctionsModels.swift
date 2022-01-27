//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation
import AnyCodable

public struct JsonFunctionDescriptor: Codable {

    let name: String
    let definition: JsonFunctionDefinition

}

public struct JsonFunctionDefinition: Codable {

    let parameters: [JsonFunctionParameter]
    let logic: AnyCodable

}

public struct JsonFunctionParameter: Codable {

    let name: String
    let `default`: AnyCodable?

}

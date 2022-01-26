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

public let optionalPrefix = "URN:UVCI:"

struct ExtractFromUVCI: Expression {

    let expression: Expression
    
    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)

        if let arr = result.array,
           let uvci = arr[0]["data"].string,
           let index = arr[1].int
        {
            guard let extractedUVCI = fromUVCI(uvci: uvci, index: Int(index)) else {
                return .Null
            }

            return JSON(extractedUVCI)
        }

        if let arr = result.array,
           let uvci = arr[0].string,
           let index = arr[1].int
        {
            guard let extractedUVCI = fromUVCI(uvci: uvci, index: Int(index)) else {
                return .Null
            }

            return JSON(extractedUVCI)
        }
        
        return .Null
    }

}

/**
 * @returns The fragment with given index from the UVCI string
 *  (see Annex 2 in the [UVCI specification](https://ec.europa.eu/health/sites/default/files/ehealth/docs/vaccination-proof_interoperability-guidelines_en.pdf)),
 *  or `null` when that fragment doesn't exist.
 */
func fromUVCI(uvci: String?, index: Int) -> String? {
    guard let uvci = uvci, index >= 0 else  {
        return nil
    }

    let prefixlessUvci = uvci.starts(with: optionalPrefix) ? uvci.substring(from: optionalPrefix.count) : uvci
    let separators = CharacterSet(charactersIn: "/#:")
    let fragments = prefixlessUvci.components(separatedBy: separators)

    return index < fragments.count ? fragments[index] : nil
}

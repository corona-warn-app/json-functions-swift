//
//  Trim.swift
//  json-functions-swift
//
//  Created by Nick Guendling on 2022-01-07.
//  Licensed under MIT
//

import Foundation
import JSON

struct Trim: Expression {

    let expression: Expression

    func evalWithData(_ data: JSON?) throws -> JSON {
        let result = try expression.evalWithData(data)

        guard let value = result.array?.first else {
            throw ParseError.InvalidParameters
        }

        let trimmedDescription = try value.innerDescription().trimmingCharacters(in: .whitespacesAndNewlines)

        return JSON(trimmedDescription)
    }

}

//
// json-functions-swift
//
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

struct DiffTime: Expression {

    let expression: Expression
    
    func eval(with data: inout JSON) throws -> JSON {
        let result = try expression.eval(with: &data)
        
        if let arr = result.array,
           let lhs = arr[0].date,
           let rhs = arr[1].date,
           let unit = arr[2].string
           {
            return rhs.timeUntil(lhs, unit: unit)
        }

        return .Null
    }

}

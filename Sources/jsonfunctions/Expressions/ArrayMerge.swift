//
// json-functions-swift
//

import Foundation

struct ArrayMerge: Expression {

    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        let dataArray = try expression.eval(with: &data)

        return .Array(recursiveFlattenArray(dataArray))
    }

    func recursiveFlattenArray(_ json: JSON) -> [JSON] {
        switch json {
        case let .Array(array):
            return array.flatMap({ recursiveFlattenArray($0) })
        default:
            return [json]
        }
    }
    
}

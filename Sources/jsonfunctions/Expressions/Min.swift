//
// json-functions-swift
//

import Foundation
import JSON

struct Min: Expression {

    let arg: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard case let .Array(array) = try arg.eval(with: &data) else {
            return .Null
        }

        return array.min() ?? .Null
    }

}
//
// json-functions-swift
//

import Foundation

protocol Expression {

    func eval(with data: inout JSON) throws -> JSON

}

extension Expression {

    func eval(with data: JSON) throws -> JSON {
        var data = data
        return try eval(with: &data)
    }

}

//
// json-functions-swift
//
// Copyright (c) 2022 SAP SE or an SAP affiliate company
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

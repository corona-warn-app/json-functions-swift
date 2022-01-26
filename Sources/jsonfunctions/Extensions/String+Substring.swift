//
// json-functions-swift
//
// Copied from: https://github.com/eu-digital-green-certificates/json-logic-swift/blob/master/Sources/jsonlogic/String%2B.swift
// in forked Repository:
// https://github.com/eu-digital-green-certificates/json-logic-swift
//
//  File.swift
//
//  Created by Alexandr Chernyy on 03.08.2021.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation

extension String {
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }

}

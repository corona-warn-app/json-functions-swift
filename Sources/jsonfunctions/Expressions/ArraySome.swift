//
// json-functions-swift
//

import Foundation

struct ArraySome: Expression {
    
    let expression: Expression

    func eval(with data: inout JSON) throws -> JSON {
        guard let array = self.expression as? ArrayOfExpressions,
              array.expressions.count >= 2,
              case let .Array(dataArray) = try array.expressions[0].eval(with: &data)
                else {
            return false
        }

        let operation = array.expressions[1]

        if let elementKey = try array.expressions[safe: 2]?.eval(with: &data).string, var dataDictionary = data.dictionary {
            let someSatisfy = try dataArray.contains {
                dataDictionary[elementKey] = $0
                var dataDictionaryJSON = JSON(dataDictionary)
                return try operation.eval(with: &dataDictionaryJSON).truthy()
            }

            return JSON(someSatisfy)
        } else {
            let someSatisfy = try dataArray.contains {
                var element = $0
                return try operation.eval(with: &element).truthy()
            }

            return JSON(someSatisfy)
        }
    }

}

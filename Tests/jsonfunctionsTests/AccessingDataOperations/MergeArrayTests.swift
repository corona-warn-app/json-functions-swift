//
//  jsonfunctionsTests
//
//      IfTests.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 11/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//


import XCTest
@testable import jsonfunctions

class MergeTests: XCTestCase {

    let emptyIntArray = [Int]()

    func testMerge() {
        var rule =
                """
                {"merge":[]}
                """
        XCTAssertEqual(emptyIntArray, try JsonFunctions().applyRule(rule, to: nil))
        rule =
                """
                {"merge":[[1]]}
                """
        XCTAssertEqual([1], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[[1],[]]}
                """
        XCTAssertEqual([1], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[[1],[2]]}
                """
        XCTAssertEqual([1, 2], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[[1], [2], [3]]}
                """
        XCTAssertEqual([1, 2, 3], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[[1, 2], [3]]}
                """
        XCTAssertEqual([1, 2, 3], try JsonFunctions().applyRule(rule, to: nil))
    }

    func testMerge_withNonArrayArguments() {
        var rule =
                """
                {"merge":1}
                """
        XCTAssertEqual([1], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[1,2]}
                """
        XCTAssertEqual([1, 2], try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                {"merge":[1,[2]]}
                """
        XCTAssertEqual([1, 2], try JsonFunctions().applyRule(rule, to: nil))
    }
}

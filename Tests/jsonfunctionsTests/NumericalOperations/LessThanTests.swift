//
//  jsonfunctionsTests
//
//      lessThanTests.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 11/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import XCTest
@testable import jsonfunctions

class LessThanTests: XCTestCase {

    func testLessThan_withNumberConstants() {
        var rule =
                """
                { "<" : [1, 3] }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [1, 1] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [3, 1] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLessThan_withNonNumbericConstants() {
        var rule =
                """
                { "<" : ["2", "1111"] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [null, null] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [null, []] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : ["1", ""] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLessThan_withMixedArgumentsTypes() {
        var rule =
                """
                { "<" : ["2", 1111] }
                """
        //When one is numeric then the other is converted to numberic
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : ["2222", 1111] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : ["b", 1111] }
                """
        //Anything but null when compared with null is greater
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [1, null] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [1, []] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [[[]], 0] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLessThan_withVariables() {
        var rule =
                """
                { "<" : [3, {"var" : ["oneNest.one"]}] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [1, {"var" : ["a"] }] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [1, ["nonExistant"]] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "<" : [0, ["b"]] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }
}

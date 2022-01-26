//
//  jsonfunctionsTests
//
//      OrTests.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 12/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import XCTest

@testable import jsonfunctions

class OrTests: XCTestCase {

    func testOr_twoBooleans() {
        var rule =
                """
                {"or": [true, true]}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "or" : [true, false] }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "or" : [false, false] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "or" : [true] }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                { "or" : [false] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testOr_mixedArguments() {
        XCTAssertEqual(1, try JsonFunctions().applyRule("""
                { "or": [1, 3] }
                """, to: nil))

        XCTAssertEqual("a", try JsonFunctions().applyRule("""
                { "or": ["a"] }
                """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
                { "or": [true,"",3] }
                """, to: nil))
    }
}

//
//  jsonfunctionsTests
//
//      AndTests.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 12/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import XCTest

@testable import jsonfunctions

class DoubleNegationTests: XCTestCase {

    func testDoubleNegation_withBooleans() {
        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "and" : [false] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "and" : [true] }
            """, to: nil))
    }

    func testDoubleNegation_withObject() {
        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : true }
            """, to: nil))

        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "!!" : false }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : "0" }
            """, to: nil))
    }

    func testDoubleNegation_withArrays() {
        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "!!" : [ [] ] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : [ [0] ] }
            """, to: nil))
    }

    func testDoubleNegation_withStrings() {
        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "!!" : [ "" ] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : [ "0" ] }
            """, to: nil))
    }

    func testDoubleNegation_withNumbers() {
        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "!!" : [ 0 ] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : [ 1 ] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : [ -1 ] }
            """, to: nil))

        XCTAssertEqual(true, try JsonFunctions().applyRule("""
            { "!!" : [ 1000 ] }
            """, to: nil))
    }

    func testDoubleNegation_withNull() {
        XCTAssertEqual(false, try JsonFunctions().applyRule("""
            { "!!" : [ null ] }
            """, to: nil))
    }
}

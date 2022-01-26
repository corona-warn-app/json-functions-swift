//
//  jsonfunctionsTests
//
//      NotStringEquals.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 11/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import XCTest

@testable import jsonfunctions

class NotStrictEquals: XCTestCase {

    func testNot_StrictEquals_withConstants() {
        let rule =
                """
                    { "!==" : [1, 2] }
                """

        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNot_StrictEquals_withConstants1() {
        let rule =
                """
                    { "!==" : [1, "1"] }
                """

        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNot_StrictEquals_withConstants2() {
        let rule =
                """
                    { "!==" : [1, 1] }
                """

        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNot_StrictEquals_withConstants3() {
        let rule =
                """
                    { "!==" : [1, []] }
                """

        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNotStringEquals_NestedVar() {
        let rule =
                """
                    { "!==" : [ {"var" : [ {"var" : ["a"]} ] }, {"var" : ["oneNest.one"]}] }
                """
        let data =
                """
                    { "a" : "b", "b" : "1", "oneNest" : {"one" : "1"} }
                """

        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: data))
    }

    func testLogicalNot_withBooleanConstants() {
        var rule =
                """
                    { "!" : [true] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    { "!" : [false] }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    {"!" : true}
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    {"!" : false}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLogicalNot_withArrays() {
        var rule =
                """
                    {"!" : []}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    {"!" : [[]]}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLogicalNot_withNumbers() {
        var rule =
                """
                    { "!" : 0 }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    { "!" : 1 }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLogicalNot_withStrings() {
        var rule =
                """
                    {"!" : ""}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    {"!" : ""}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
                """
                    {"!" : "1"}
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLogicalNot_withNull() {
        let rule =
                """
                    {"!" : null}
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testLogicalNot_withVariables() {
        let data =
                """
                    { "a" : "b", "b" : "1", "oneNest" : {"one" : true} }
                """

        var rule =
                """
                    { "!" : [ {"var" : ["oneNest.one"] } ] }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: data ))

        rule =
                """
                    { "!" : {"var" : ["a"] } }
                """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: data ))

        rule =
                """
                    { "!" : {"var" : ["nonExistant"] } }
                """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: data ))
    }
}

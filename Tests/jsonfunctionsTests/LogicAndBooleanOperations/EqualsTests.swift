//
//  jsonfunctionsTests
//
//      EqualsTests.swift
//      jsonlogicTests
//
//      Created by Christos Koninis on 17/02/2019.
//
// Modifications Copyright (c) 2022 SAP SE or an SAP affiliate company
//

import Foundation
import XCTest
@testable import jsonfunctions

class EqualsTests: XCTestCase {

    func testEquals() {
        var rule =
        """
        {"==":[1,1]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[1,2]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testEquals_WithTypeCoercion() {
        var rule =
        """
        {"==":[1,"1"]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[1,"2"]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[1,"1.0"]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[null,1]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[0,false]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"==":[[1],[1]]}
        """
        //http://jsonfunctions.com/play.html returns false here
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNotEquals() {
        var rule =
        """
        {"!=":[1,2]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"!=":[1,1]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"!=":[1,"1"]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))
    }

    func testNotEquals_WithTypeCoersion() {
        var rule =
        """
        {"!=":[1,"1"]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"!=":[1,"1.0"]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"!=":[0,true]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: nil))
    }
}

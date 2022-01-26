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

class CompoundTests: XCTestCase {

    func testCompound() {
        var rule =
        """
        {"and":[{">":[3,1]},true]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: "{}"))

        rule =
        """
        {"and":[{">":[3,1]},false]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: "{}"))

        rule =
        """
        {"and":[{">":[3,1]},{"!":true}]}
        """
        XCTAssertEqual(false, try JsonFunctions().applyRule(rule, to: "{}"))

        rule =
        """
        {"and":[{">":[3,1]},{"<":[1,3]}]}
        """
        XCTAssertEqual(true, try JsonFunctions().applyRule(rule, to: "{}"))

        rule =
        """
        {"?:":[{">":[3,1]},"visible","hidden"]}
        """
        XCTAssertEqual("visible", try JsonFunctions().applyRule(rule, to: "{}"))
    }
}

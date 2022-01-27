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

//swiftlint:disable function_body_length
class MissingTests: XCTestCase {

    let emptyStringArray = [String]()

    func testVar_withEmptyVarName() {
        let rule =
                """
                {"var":[""]}
                """
        let data =
                """
                [1, 2, 3]
                """
        XCTAssertEqual([1, 2, 3], try JsonFunctions().applyRule(rule, to: data))
    }

    func testMissing() {
        var rule =
        """
        {"missing":["a", "b"]}
        """
        var data =
        """
        {"a":"apple", "c":"carrot"}
        """
        XCTAssertEqual(["b"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a", "b"]}
        """
        data =
        """
        {"a":"apple", "b":"banana"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":[]}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"missing":["a"]}
        """
        XCTAssertEqual(["a"], try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"missing":"a"}
        """
        XCTAssertEqual(["a"], try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"missing":"a"}
        """
        data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a"]}
        """
        data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a","b"]}
        """
        data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(["b"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a","b"]}
        """
        data =
        """
        {"b":"banana"}
        """
        XCTAssertEqual(["a"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a","b"]}
        """
        data =
        """
        {"a":"apple", "b":"banana"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a","b"]}
        """
        data =
        """
        {}
        """
        XCTAssertEqual(["a", "b"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a","b"]}
        """
        XCTAssertEqual(["a", "b"], try JsonFunctions().applyRule(rule, to: nil))
    }

    func testMissing_NestedKeys() {
        var rule =
        """
        {"missing":["a.b"]}
        """
        var data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(["a.b"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a.b"]}
        """
        XCTAssertEqual(["a.b"], try JsonFunctions().applyRule(rule, to: nil))

        rule =
        """
        {"missing":["a.b"]}
        """
        data =
        """
        {"a":{"c":"apple cake"}}
        """
        XCTAssertEqual(["a.b"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a.b"]}
        """
        data =
        """
        {"a":{"b":"apple brownie"}}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing":["a.b", "a.c"]}
        """
        data =
        """
        {"a":{"b":"apple brownie"}}
        """
        XCTAssertEqual(["a.c"], try JsonFunctions().applyRule(rule, to: data))
    }

    func testMissing_some() {
        var rule =
        """
        {"missing_some":[1, ["a", "b"]]}
        """
        var data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing_some":[1, ["a", "b"]]}
        """
        data =
        """
        {"b":"banana"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing_some":[1, ["a", "b"]]}
        """
        data =
        """
        {"b":"banana"}
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing_some":[2, ["a", "b", "c"]]}
        """
        data =
        """
        {"a":"apple"}
        """
        XCTAssertEqual(["b", "c"], try JsonFunctions().applyRule(rule, to: data))

        //Following the rules for var for . notation
        rule =
        """
        {"missing_some":[2, ["person.name", "b", "c"]]}
        """
        data =
        """
        {"a":"apple", "person": {"name": "Bruce"} }
        """
        XCTAssertEqual(["b", "c"], try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"missing_some":[1, ["person.name", "b", "c"]]}
        """
        data =
        """
        {"a":"apple", "person": {"name": "Bruce"} }
        """
        XCTAssertEqual(emptyStringArray, try JsonFunctions().applyRule(rule, to: data))

        //with wrong arguments
        rule =
        """
        {"missing_some":[1]}
        """
        data =
        """
        {"b":"banana"}
        """
        XCTAssertNil(try JsonFunctions().applyRule(rule, to: data))

        rule =
        """
        {"if" :[
            {"merge": [
            {"missing":["first_name", "last_name"]},
            {"missing_some":[1, ["cell_phone", "home_phone"] ]}
        ]},
        "We require first name, last name, and one phone number.",
        "OK to proceed"
        ]}
        """

        data =
        """
        {"first_name":"Bruce", "last_name":"Wayne"}
        """
        XCTAssertEqual("We require first name, last name, and one phone number.", try JsonFunctions().applyRule(rule, to: data))
    }
}

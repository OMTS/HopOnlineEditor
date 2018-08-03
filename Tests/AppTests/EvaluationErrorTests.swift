//
//  EvaluationErrorTests.swift
//  App
//
//  Created by Iman Zarrabian on 03/08/2018.
//

@testable import App
import Vapor
import XCTest

final class EvaluationErrorTests: XCTestCase {
    var scriptError: ScriptError!

    override func setUp() {
        scriptError = ScriptError(reason: "Dummy Error", lineNumber: 99, position: 42)
    }

    override func tearDown() {
        scriptError = nil
    }
    func testErrorCreation() throws {
        let error = EvaluationError(error: scriptError)
        XCTAssertEqual(error.error.reason, "Dummy Error")
        XCTAssertEqual(error.error.lineNumber, 99)
        XCTAssertEqual(error.error.position, 42)

    }

    func testErrorJsonString() throws {
        let error = EvaluationError(error: scriptError)
        let jsonString = error.jsonString
        let resultString = "{\"error\" : { \"lineNumber\": 99, \"position\": 42, \"reason\" :\"Dummy Error\"}}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(jsonString)
        XCTAssertEqual(jsonString!.replacingOccurrences(of: " ", with: ""), resultString)
    }


    static let allTests = [("testErrorCreation", testErrorCreation),
                           ("testErrorJsonString", testErrorJsonString)]

}

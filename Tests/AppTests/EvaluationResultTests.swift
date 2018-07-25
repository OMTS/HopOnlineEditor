//
//  EvaluationResultTests.swift
//  App
//
//  Created by Iman Zarrabian on 25/07/2018.
//

@testable import App
import Vapor
import XCTest

final class EvaluationResultTests: XCTestCase {
    func testResultCreation() throws {
        let result = EvaluationResult(result: "Dummy")
        XCTAssertEqual(result.result, "Dummy")
    }

    func testResultJsonString() throws {
        let result = EvaluationResult(result: "Dummy")
        let jsonString = result.jsonString
        let resultString = "{\"result\" : \"Dummy\"}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(jsonString)
        XCTAssertEqual(jsonString!.replacingOccurrences(of: " ", with: ""), resultString)
    }


    static let allTests = [("testResultCreation", testResultCreation),
                           ("testResultJsonString", testResultJsonString)]

}

//
//  HopControllerTests.swift
//  App
//
//  Created by Iman Zarrabian on 07/08/2018.
//

@testable import App
import Vapor
import XCTest

final class HopControllerTests: XCTestCase {
    var app: Application!
    static let allTests = [("testKeywordsApi", testKeywordsApi)]

    override func setUp() {
        app = try! Application.testable()
    }

    func testKeywordsApi() throws {
        let keywords = try app.getResponse(
            to: "/api/hop/keywords",
            method: .GET,
            headers: ["Content-Type": "application/json"],
            decodeTo: Keywords.self)

        XCTAssertGreaterThan(keywords.keywords.count, 0)
    }
}

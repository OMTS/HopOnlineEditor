//
//  EditorTests.swift
//  AppTests
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest

final class EditorTests: XCTestCase {
    var app: Application!

    override func setUp() {
        app = try! Application.testable()
    }

    func testLanguageVersion() throws {
        let receivedVersion = try app.getResponse(
            to: "/api/version",
            method: .GET,
            headers: ["Content-Type": "application/json"],
            decodeTo: LanguageVersion.self)
        XCTAssertEqual(receivedVersion.version, "0.0.1")
    }

    static let allTests = [("testLanguageVersion", testLanguageVersion)]

}

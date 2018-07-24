//
//  SessionTests.swift
//  App
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest

final class SessionTests: XCTestCase {
    func testSessionCreation() throws {
        let session = SessionCookie(cookie: "Dummy")
        XCTAssertEqual(session.cookie, "session=Dummy")
    }

    func testSessionJsonString() throws {
        let session = SessionCookie(cookie: "Dummy")
        let jsonString = session.jsonString
        let resultString = "{\"cookie\" : \"session=Dummy\"}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(jsonString)
        XCTAssertEqual(jsonString!.replacingOccurrences(of: " ", with: ""), resultString)
    }


    static let allTests = [("testSessionCreation", testSessionCreation),
                           ("testSessionJsonString", testSessionJsonString)]

}

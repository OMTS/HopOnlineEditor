//
//  OnlineScriptTests.swift
//  AppTests
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest

final class OnlineScriptTests: XCTestCase {
    func testScriptCreation() throws {
        let script = OnlineScript(script: "import Sys")
        XCTAssertEqual(script.script, "import Sys")
    }

    static let allTests = [("testScriptCreation", testScriptCreation)]
}

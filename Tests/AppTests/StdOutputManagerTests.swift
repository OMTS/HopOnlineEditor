//
//  StdOutputManagerTests.swift
//  AppTests
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest

final class StdOutputManagerTests: XCTestCase {
    func testStdoutManagerCreation() throws {
        let manager = StdOutputManager()
        XCTAssertEqual(manager.sessions.count, 0)
    }

    func testStdoutManagerAdd() throws {
        let manager = StdOutputManager()
        let stdout = Stdout(descriptor: MockWebsocket(), sessionId: "DummySesson")
        manager.add(output: stdout, to: "first_key")

        XCTAssertEqual(manager.sessions.count, 1)
        XCTAssertNotNil(manager.sessions["first_key"])
        XCTAssertEqual((manager.sessions["first_key"]!.descriptor as! MockWebsocket).mockName, "Mocked!")
    }

    func testStdoutManagerRedundantAdd() throws {
        let manager = StdOutputManager()
        let stdout = Stdout(descriptor: MockWebsocket(), sessionId: "DummySesson")
        let newDescriptor = MockWebsocket()
        newDescriptor.mockName = "YO"
        let stdout2 = Stdout(descriptor: newDescriptor, sessionId: "DummySesson")

        manager.add(output: stdout, to: "first_key")
        manager.add(output: stdout2, to: "first_key")

        XCTAssertEqual(manager.sessions.count, 1)
        XCTAssertNotNil(manager.sessions["first_key"])
        XCTAssertEqual((manager.sessions["first_key"]!.descriptor as! MockWebsocket).mockName, "Mocked!")
    }

    func testStdoutManagerRemove() throws {
        let manager = StdOutputManager()
        let stdout = Stdout(descriptor: MockWebsocket(), sessionId: "DummySesson")
        manager.add(output: stdout, to: "first_key")
        XCTAssertEqual(manager.sessions.count, 1)

        manager.remove(output: stdout, from: "first_key")
        XCTAssertEqual(manager.sessions.count, 0)
    }


    static let allTests = [("testStdoutManagerCreation", testStdoutManagerCreation),
                           ("testStdoutManagerAdd", testStdoutManagerAdd),
                           ("testStdoutManagerRedundantAdd", testStdoutManagerRedundantAdd),
                           ("testStdoutManagerRemove", testStdoutManagerRemove)]
}

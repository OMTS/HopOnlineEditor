//
//  StdOutTests.swift
//  App
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest
import Hop

final class StdOutTests: XCTestCase {

    func testStdOutCreation() throws {
        let descriptor = MockWebsocket()
        let stdout = Stdout(descriptor: descriptor)
        XCTAssertEqual((stdout.descriptor as! MockWebsocket)
            .mockName, "Mocked!")
    }

    func testStdOutHasAMessenger() throws {
        let descriptor = MockWebsocket()
        let messenger = MessengerMocks()
        let stdout = Stdout(descriptor: descriptor, messenger: messenger)

        stdout.registerForOutput()

        XCTAssertNotNil(stdout.messenger)
    }

    func testStdOutRegistering() throws {
        let descriptor = MockWebsocket()
        let messenger = MessengerMocks()
        let stdout = Stdout(descriptor: descriptor, messenger: messenger)

        stdout.registerForOutput()
        messenger.executeHandler(result: "YOLO")

        let expectedResult = "{\"result\":\"YOLO\"}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(descriptor.printResult)
        XCTAssertEqual(descriptor.printResult!.replacingOccurrences(of: " ", with: ""), expectedResult)
    }

    func testStdOutUnRegistering() throws {
    }

    static let allTests = [("testStdOutCreation", testStdOutCreation),
                           ("testStdOutHasAMessenger", testStdOutHasAMessenger),
                           ("testStdOutRegistering", testStdOutRegistering),
                           ("testStdOutUnRegistering", testStdOutUnRegistering)]
}

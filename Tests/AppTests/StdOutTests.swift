//
//  StdOutTests.swift
//  App
//
//  Created by Iman Zarrabian on 24/07/2018.
//

@testable import App
import Vapor
import XCTest

final class StdOutTests: XCTestCase {

    func testStdOutCreation() throws {
        let descriptor = MockWebsocket()
        let stdout = Stdout(descriptor: descriptor)
        XCTAssertEqual((stdout.descriptor as! MockWebsocket)
            .mockName, "Mocked!")
    }

    func testStdOutHasObserver() throws {
        let descriptor = MockWebsocket()
        let stdout = Stdout(descriptor: descriptor)
        stdout.registerForOutput()

        XCTAssertNotNil(stdout.printObserver)
    }

    func testStdOutRegistering() throws {
        let descriptor = MockWebsocket()
        let stdout = Stdout(descriptor: descriptor)
        stdout.registerForOutput()
        NotificationCenter.default.post(name: printNotification,
                                        object: nil,
                                        userInfo: [notificationMessageInfosKey : "YOLO"])

//        let expectation = XCTestExpectation(description: "Register From NotificationCenter")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 2.0)

        let expectedResult = "{\"result\":\"YOLO\"}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(descriptor.printResult)
        XCTAssertEqual(descriptor.printResult!.replacingOccurrences(of: " ", with: ""), expectedResult)
    }

    func testStdOutUnRegistering() throws {
        let descriptor = MockWebsocket()
        let stdout = Stdout(descriptor: descriptor)

        stdout.registerForOutput()
        NotificationCenter.default.post(name: printNotification,
                                        object: nil,
                                        userInfo: [notificationMessageInfosKey : "YOLO2"])

//        let expectation = XCTestExpectation(description: "Unregister From NotificationCenter")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 2.0)


        let expectedResult = "{\"result\":\"YOLO2\"}".replacingOccurrences(of: " ", with: "")
        XCTAssertNotNil(descriptor.printResult)
        XCTAssertEqual(descriptor.printResult!.replacingOccurrences(of: " ", with: ""), expectedResult)

        stdout.unregisterForOutput()
        NotificationCenter.default.post(name: printNotification,
                                        object: nil,
                                        userInfo: [notificationMessageInfosKey : "YOLO3"])

//        let expectation2 = fXCTestExpectation(description: "Unregister2 From NotificationCenter")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            expectation2.fulfill()
//        }
//        wait(for: [expectation2], timeout: 2.0)

        XCTAssertEqual(descriptor.printResult!.replacingOccurrences(of: " ", with: ""), expectedResult)

    }

    static let allTests = [("testStdOutCreation", testStdOutCreation),
                           ("testStdOutHasObserver", testStdOutHasObserver),
                           ("testStdOutRegistering", testStdOutRegistering),
                           ("testStdOutUnRegistering", testStdOutUnRegistering)]
}

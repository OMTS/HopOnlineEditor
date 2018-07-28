//
//  StdOutMocks.swift
//  AppTests
//
//  Created by Iman Zarrabian on 24/07/2018.
//

import Foundation
@testable import App

final class MockWebsocket: OuputDesriptor {
    var printResult: String?
    var mockName = "Mocked!"

    func print(message: String) {
        printResult = message
    }
}

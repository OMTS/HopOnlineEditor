import XCTest

@testable import AppTests

XCTMain([
    testCase(StdOutputManagerTests.allTests),
    testCase(SessionTests.allTests),
    testCase(OnlineScriptTests.allTests),
    testCase(StdOutTests.allTests),
    testCase(EditorTests.allTests),
    testCase(HopControllerTests.allTests)
    ])

//
//  StdOutput.swift
//  App
//
//  Created by Iman Zarrabian on 21/07/2018.
//

import Foundation
import Vapor

struct StdOutput {
    func registerEvaluation(outputPromise: EventLoopPromise<EvaluationContext>, inputScript: String) {
        NotificationCenter.default.addObserver(forName: printNotification,
                                               object: nil,
                                               queue: nil) { notification in
                                                var context: EvaluationContext!
                                                if let message = notification.userInfo?[notificationMessageInfosKey] as? String {
                                                    context = EvaluationContext(title: "Hop Inline Edtior", script: inputScript, executionResult: message)
                                                } else {
                                                    context = EvaluationContext(title: "Hop Inline Edtior", script: inputScript, executionResult: "Execution Error!")
                                                }

                                                outputPromise.succeed(result: context) //Should treat the error as an actual failing case

        }
    }
}

//
//  StdOut.swift
//  App
//
//  Created by Iman Zarrabian on 23/07/2018.
//

import Foundation

final class Stdout {
    let descriptor: OuputDesriptor
    var printObserver: Any?

    init(descriptor: OuputDesriptor) {
        self.descriptor = descriptor
    }

    func registerForOutput() {
        printObserver = NotificationCenter.default.addObserver(forName: printNotification, object: nil,
                                               queue: nil) {[weak self] notification in

                                                if let message = notification.userInfo?[notificationMessageInfosKey] as? String {

                                                    let result = EvaluationResult(result: message)
                                                    if let jsonString = result.jsonString {
                                                        self?.descriptor.print(message: jsonString)
                                                    }
                                                }
        }
    }

    func unregisterForOutput() {
        if let printObserver = printObserver {
            NotificationCenter.default.removeObserver(printObserver, name: printNotification, object: nil)
        }
    }
}

//
//  StdOut.swift
//  App
//
//  Created by Iman Zarrabian on 23/07/2018.
//

import Foundation
import Hop

enum StdoutError: Error {
    case alreadyRegisteredError
}

final class Stdout {
    let descriptor: OuputDesriptor
    let sessionId: String
    var messenger: MessengerType!

    init(descriptor: OuputDesriptor, sessionId: String, messenger: MessengerType? = nil) {
        self.descriptor = descriptor
        self.sessionId = sessionId
        self.messenger = messenger ?? Messenger(sessionId: sessionId)
    }

    func registerForOutput() {
        // Configure stdout callback
        messenger!.subscribe(to: .stdout) { [weak self] (_, message) in
            if let message = message.data as? String {
                let result = EvaluationResult(result: message)
                if let jsonString = result.jsonString {
                    self?.descriptor.print(message: jsonString)
                }
            }
        }
    }

    func unregisterForOutput() {
        //implement unsubscribe in Messenger instance in Hop
    }
}

extension Messenger: MessengerType {}

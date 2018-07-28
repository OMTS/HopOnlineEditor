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
    var messenger: MessengerType!

    init(descriptor: OuputDesriptor, messenger: MessengerType? = nil) {
        self.descriptor = descriptor
        self.messenger = messenger ?? Messenger()
    }

    func registerForOutput() {
        // Configure stdout callback
        messenger!.subscribe(to: .stdout) { [weak self] (message) in
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

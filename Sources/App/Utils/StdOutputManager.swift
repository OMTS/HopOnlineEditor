//
//  StdOutput.swift
//  App
//
//  Created by Iman Zarrabian on 21/07/2018.
//

import Foundation
import Vapor

protocol OuputDesriptor {
    func print(message: String)
}
extension WebSocket: OuputDesriptor {
    func print(message: String) {
        send(message)
    }
}

final class Stdout {
    let descriptor: OuputDesriptor

    init(descriptor: OuputDesriptor) {
        self.descriptor = descriptor
    }

    func registerForOutput() {
        NotificationCenter.default.addObserver(forName: printNotification, object: nil,
                                               queue: nil) {[weak self] notification in

                                                if let message = notification.userInfo?[notificationMessageInfosKey] as? String {
                                                    let json = "{\"result\": \"\(message)\"}"
                                                    self?.descriptor.print(message: json)
                                                }
        }
    }

    func unregisterForOutput() {
        NotificationCenter.default.removeObserver(self)
    }
}
final class StdOutputManager { //should be replaced by a reddis for example

    private(set) var sessions: LockedDictionary<String, Stdout> = [:]
    
    func add(output: Stdout, to session: String) {
        guard sessions[session] == nil else {
            return
        }
        sessions[session] = output
    }

    func remove(output: Stdout, from session: String) {
        guard sessions[session] != nil else {
            return
        }
        sessions[session] = nil
    }

    func writeToStdout(session: String, message: String) {

    }
}

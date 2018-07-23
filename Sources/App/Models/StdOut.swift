//
//  StdOut.swift
//  App
//
//  Created by Iman Zarrabian on 23/07/2018.
//

import Foundation

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

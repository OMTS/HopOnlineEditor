//
//  MessengerMocks.swift
//  App
//
//  Created by Iman Zarrabian on 26/07/2018.
//

import Foundation
@testable import Hop
@testable import App

final class MessengerMocks: MessengerType {
    var handler: Messenger.MessageHandler!

    func subscribe(to messageType: MessageType, handler: @escaping Messenger.MessageHandler) {
        self.handler = handler
    }

    func executeHandler(result: String) {
        let messageObj = Message(type: .stdout, identifier: nil, data: result)
        handler(messageObj)
    }
}

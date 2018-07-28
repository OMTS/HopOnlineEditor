//
//  OutputDescriptor.swift
//  App
//
//  Created by Iman Zarrabian on 23/07/2018.
//

import Foundation
import Hop

protocol OuputDesriptor {
    func print(message: String)
}

protocol MessengerType {
    func subscribe(to messageType: MessageType, handler: @escaping Messenger.MessageHandler)
}


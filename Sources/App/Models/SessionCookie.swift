//
//  Session.swift
//  App
//
//  Created by Iman Zarrabian on 24/07/2018.
//

import Foundation
import Vapor

final class SessionCookie: Codable, JsonStringRepresantable {
    var cookie: String

    init(cookie: String) {
        self.cookie = "session="+cookie
    }
}

extension SessionCookie: Content {}

//
//  Session.swift
//  App
//
//  Created by Iman Zarrabian on 24/07/2018.
//

import Foundation
import Vapor

final class SessionCookie: Codable {
    var cookie: String

    var jsonString: String? {
        if let data = try? JSONEncoder().encode(self) {
            return String(data: data, encoding: .utf8)
        } else { return nil }
    }

    init(cookie: String) {
        self.cookie = "session="+cookie
    }
}

extension SessionCookie: Content {}

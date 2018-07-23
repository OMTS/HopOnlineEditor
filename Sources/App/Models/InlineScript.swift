//
//  OnlineScript.swift
//  App
//
//  Created by Iman Zarrabian on 20/07/2018.
//

import Foundation
import Vapor

final class OnlineScript: Codable {
    var script: String

    init(script: String) {
        self.script = script
    }
}

extension OnlineScript: Content {}

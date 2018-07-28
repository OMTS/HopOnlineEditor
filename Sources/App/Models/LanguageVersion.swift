//
//  LanguageVersion.swift
//  AppTests
//
//  Created by Iman Zarrabian on 24/07/2018.
//

import Foundation
import Vapor

final class LanguageVersion: Codable {
    var version: String

    init(version: String) {
        self.version = version
    }
}

extension LanguageVersion: Content {}


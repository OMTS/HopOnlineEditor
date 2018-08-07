//
//  Keyword.swift
//  App
//
//  Created by Iman Zarrabian on 07/08/2018.
//

import Foundation
import Vapor

final class Keywords: Codable {
    var keywords: [String]

    init(keywords: [String]) {
        self.keywords = keywords
    }
}

extension Keywords: Content {}

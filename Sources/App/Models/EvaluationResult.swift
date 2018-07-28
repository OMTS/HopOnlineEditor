//
//  EvaluationResult.swift
//  App
//
//  Created by Iman Zarrabian on 25/07/2018.
//

import Foundation
import Vapor

final class EvaluationResult: Codable, JsonStringRepresantable {
    var result: String

    init(result: String) {
        self.result = result
    }
}

extension EvaluationResult: Content {}


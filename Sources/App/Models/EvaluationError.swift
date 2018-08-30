//
//  EvaluationError.swift
//  App
//
//  Created by Iman Zarrabian on 03/08/2018.
//

import Foundation
import Vapor

struct ScriptError: Codable {
    var reason: String
    var lineNumber: Int
    var position: Int
}
final class EvaluationError: Codable, JsonStringRepresantable {

    let error: ScriptError

    init(error: ScriptError) {
        self.error = error
    }
}

extension EvaluationError: Content {}



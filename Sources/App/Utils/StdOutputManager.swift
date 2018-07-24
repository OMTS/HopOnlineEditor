//
//  StdOutput.swift
//  App
//
//  Created by Iman Zarrabian on 21/07/2018.
//

import Foundation
import Vapor

final class StdOutputManager { //should be replaced by a reddis for example

    private(set) var sessions: LockedDictionary<String, Stdout> = [:]
    
    func add(output: Stdout, to session: String) {
        guard sessions[session] == nil else {
            return
        }
        sessions[session] = output
    }

    func remove(output: Stdout, from session: String) {
        guard sessions[session] != nil else {
            return
        }
        sessions[session] = nil
    }
}

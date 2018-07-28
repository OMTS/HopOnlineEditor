//
//  JsonStringRepresantable.swift
//  App
//
//  Created by Iman Zarrabian on 25/07/2018.
//

import Foundation

protocol JsonStringRepresantable {
    var jsonString: String? { get }
}


extension JsonStringRepresantable where Self: Codable  {
    var jsonString: String? {
        if let data = try? JSONEncoder().encode(self) {
            return String(data: data, encoding: .utf8)
        } else { return nil }
    }
}

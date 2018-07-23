//
//  EditorController.swift
//  App
//
//  Created by Iman Zarrabian on 20/07/2018.
//

import Vapor
import Leaf

final class EditorController: RouteCollection {
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.get("version", use: versionHandler)
    }

    private func indexHandler(_ req: Request) throws -> Future<View> {
        let context = EditorContext(title: "Hop Inline Edtior")
        return try req.view().render("index", context)
    }

    private func versionHandler(_ req: Request) throws -> String {
        return "Hop v0.0.1"
    }
}

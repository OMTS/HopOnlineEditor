//
//  HopController.swift
//  App
//
//  Created by Iman Zarrabian on 07/08/2018.
//

import Foundation
import Vapor
import Hop

struct HopController: RouteCollection {

    func boot(router: Router) throws {
        let hopRoute = router.grouped("api", "hop")
        hopRoute.get("keywords", use: getAllKeywordsHandler)
        hopRoute.get("version", use: versionHandler)
    }

    private func getAllKeywordsHandler(_ req: Request) -> Future<Keywords> {

        let promiseKeywords = req.eventLoop.newPromise(Keywords.self)
        DispatchQueue.global(qos: .background).async {
            promiseKeywords.succeed(result:Keywords(keywords: Array(Token.reservedKeywords).map { $0.rawValue }))
        }

        return promiseKeywords.futureResult
    }

    private func versionHandler(_ req: Request) throws -> LanguageVersion {
        //Need a way to get the language version from Hop Dependency
        return LanguageVersion(version: "0.1.4")
    }
}

//
//  EditorController.swift
//  App
//
//  Created by Iman Zarrabian on 20/07/2018.
//

import Vapor
import Leaf

final class EditorController: RouteCollection {
   // var executionResult = ""
   // var currentScript = ""
    let outputs = [StdOutput]()
    //let cache = [id: ws]
    let idCount = 0
    func boot(router: Router) throws {
        router.get(use: indexHandler)
        router.post(InlineScript.self, use: createScriptHandler)
        /*router.web("/listen") { ws
            //generate ID
            //Write ID TO THE WS
            cache[idCount] = ws
        }*/
       // registerNotification()
    }


    private func registerNotification() {
    /*    NotificationCenter.default.addObserver(forName: printNotification,
                                               object: nil,
                                               queue: nil) { [weak self] notification in
                                                if let message = notification.userInfo?[notificationMessageInfosKey] as? String {
                                                    self?.executionResult += message
                                                    print("NEW RESULT:" + self!.executionResult)
                                                }
        }
*/
     }

    private func indexHandler(_ req: Request) throws -> Future<View> {
        let context = EditorContext(title: "Hop Inline Edtior")
        return try req.view().render("index", context)
    }

    private func createScriptHandler(_ req: Request, data: InlineScript) throws -> Future<HTTPStatus> {

        let filteredScript = data.script.replacingOccurrences(of: "\r\n", with: "\n")
        //maybe we should treat \r\n in the lexer
        let script = InlineScript(script: filteredScript)

        //let newOutput = StdOutput()
        //let promiseEvaluation = req.eventLoop.newPromise(EvaluationContext.self)
       // newOutput.registerEvaluation(outputPromise: promiseEvaluation, inputScript: filteredScript)

//        NotificationCenter.default.addObserver(forName: printNotification,
//                                               object: nil,
//                                               queue: nil) { [weak self] notification in
//                                                if let message = notification.userInfo?[notificationMessageInfosKey] as? String {
//                                                    //print("NEW RESULT:" + self!.executionResult)
//                                                    let evalContext = EvaluationContext(title: "BIM", script: "", executionResult: message)
//                                                    promiseEvaluation.succeed(result: evalContext)
//                                                }
       // }

        let lexer = Lexer(script: script.script + "\n")
        let parser = Parser(with: lexer)
        if let program = try parser.parseProgram() {
           /* program.setSTDoutHandler { string in
                //GETB COOKIE
                //FIND THE WS FROM THE COOKIE
                //WRITE TO THE CORRECT Websocket

            }*/
            print("------------- parsing OK -----------\n")
            try program.perform()
            print("------------- perform OK -----------\n")
        }

        return Future.map(on: req) { HTTPStatus.noContent }
       // return promiseEvaluation.futureResult.flatMap { context in
       //     try req.view().render("index", context)
       // }
    }
}

import Vapor

let sessionManager = StdOutputManager()

public func sockets(_ websockets: NIOWebSocketServer) {
    websockets.get("listen-evaluation") { ws, req in
        let uuid = UUID().uuidString
        let session = SessionCookie(cookie: uuid)
        if let jsonString = session.jsonString {
            ws.send(jsonString)
        }

        let stdout = Stdout(descriptor: ws)
        sessionManager.add(output:stdout, to: uuid)
        stdout.registerForOutput()

        ws.onText {ws, text in
            if let oScript = try? JSONDecoder().decode(OnlineScript.self, from: text){
                try? treatScript(script: oScript.script, on: stdout)
            }
        }

        ws.onCloseCode({ (errorCode) in
            stdout.unregisterForOutput()
            sessionManager.remove(output: stdout, from: uuid)
            print("websocket closed because: \(errorCode)")
        })
    }
}

private func treatScript(script: String, on stdout: Stdout) throws {
    let filteredScript = script.replacingOccurrences(of: "\r\n", with: "\n")
    //maybe we should treat \r\n in the lexer
    let script = OnlineScript(script: filteredScript)

    let lexer = Lexer(script: script.script + "\n")
    let parser = Parser(with: lexer)
    if let program = try parser.parseProgram() {
        /* program.setSTDoutHandler { string in
         WRITE TO THE Websocket
         }*/
        print("------------- parsing OK -----------\n")
        try program.perform()
        print("------------- perform OK -----------\n")
    }
}

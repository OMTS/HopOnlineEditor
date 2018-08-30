import Vapor
import Hop

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
    let script = OnlineScript(script: filteredScript + "\n")

    // Setup runtime session
    let session = Hop.Session(isDebug: true,
                          messenger: stdout.messenger as? Messenger,
                          getScriptForModule: nil)

    do {
        // Run script
        try session.run(script: script.script)

    } catch let error {
        if let printableError = error as? ProgramError {
            let scriptError = ScriptError(reason: printableError.getDescription, lineNumber: printableError.debugInfo?.lineNumber ?? 0, position: printableError.debugInfo?.position ?? 0)

            let evaluationError = EvaluationError(error: scriptError)
            if let jsonString = evaluationError.jsonString {
                stdout.descriptor.print(message: jsonString)
            }
        } else {
            stdout.descriptor.print(message: "Error: \(error)")
        }
    }


}

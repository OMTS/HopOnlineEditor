import Vapor
import WebSocket
import Foundation
extension WebSocket {
    func send(cookie: [String: String]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(cookie) else {
            return
        }
        //let decoder = JSONDecoder()
        //print(try! decoder.decode([String:String].self, from: data))
        send(data)
    }
}

//
//  Connection.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Foundation

struct Connection {
    var name: String
    var connected: Bool
    var recentAccess: Date
    var address: String
}

class ConnectionStore {
    private var connections: [Connection]
    init() {
        self.connections = []
    }

    func parseData(data: String) -> Connection? {
        let keys = data.components(separatedBy: CharacterSet.init(charactersIn: ","))
        if(keys.count != 6) {
            return nil
        }
        
        let address = keys[0].replacingOccurrences(of: "address: ", with: "")
        
        var name = keys[4].replacingOccurrences(of: "name: ", with: "")
        name = name.replacingOccurrences(of: "\"", with: "")
        
        var connected = true
        if(keys[2].contains("not connected")) {
            connected = false
        }
        
        //@todo parse recent access date
        return Connection(name: name, connected: connected, recentAccess: Date(), address: address)
    }
    func addConnection(connection: Connection) {
        self.connections.append(connection)
    }
    func getConnectionByID(id: Int) -> Connection? {
        return self.connections[id]
    }
    func getConnectionsCount() -> Int {
        return self.connections.count
    }
}





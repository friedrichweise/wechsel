//
//  blueutilBridge.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Foundation

class blueutilBridge {
    let store: ConnectionStore = ConnectionStore()
    let execPath = Bundle.main.resourceURL!.appendingPathComponent("blueutil").path

    init() {
        let (result, status) = shell(launchPath: self.execPath, arguments: ["--recent"])

        if(status != 0) {
            return
        }
        let lineArray = result!.components(separatedBy: .newlines)
        for line in lineArray {
            let con = store.parseData(data: line)
            if let con = con {
                store.addConnection(connection: con)
            }
        }
    }
    func connectToDevice(address: String) -> Int{
        let (result, status) = shell(launchPath: self.execPath, arguments: ["--connect", address])
        print(result!)
        return Int(status)

    }
    // from https://stackoverflow.com/a/39364135
    func shell(launchPath: String, arguments: [String] = []) -> (String? , Int32) {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        task.waitUntilExit()
        return (output, task.terminationStatus)
    }
}

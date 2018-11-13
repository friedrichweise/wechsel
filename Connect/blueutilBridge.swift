//
//  blueutilBridge.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Foundation

class blueutilBridge {
    init() {
        let execPath = Bundle.main.resourceURL!.appendingPathComponent("blueutil").path
        let (result, status) = shell(launchPath: execPath, arguments: ["--recent"])
        if(status==0) {
            print("Recent Devices:\n\(result!)")
        } else {
            //handle error
            print("Error executing blueutil")
        }
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

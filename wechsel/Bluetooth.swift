//
//  Bluetooth.swift
//  wechsel
//
//  Created by Friedrich Weise on 20.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Foundation
import IOBluetooth

class Bluetooth {
    
    let numberOfDevices: UInt
    
    init(numberOfDevices: Int) {
        self.numberOfDevices = UInt(numberOfDevices)
    }
    
    func getDevices() -> [IOBluetoothDevice] {
        guard let devices = IOBluetoothDevice.recentDevices(self.numberOfDevices) as? [IOBluetoothDevice] else {
            print("Error accessing IOBluetoothDevice.recentDevices")
            return []
        }
        return devices
    }
    
    func connectToDevices(device: IOBluetoothDevice) -> Error? {
        let result = device.openConnection()
        return evaulateIOReturn(returnValue: result)
    }
    
    func disconnectFromDevice(device: IOBluetoothDevice) -> Error? {
        let result = device.closeConnection()
        return evaulateIOReturn(returnValue: result)
    }
    
    func evaulateIOReturn(returnValue: IOReturn) -> Error? {
        //@todo: evualte ioreturn and map to usefull Error Types
        return nil
    }
    
}

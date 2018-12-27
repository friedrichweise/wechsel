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
    
    func connectToDevices(device: IOBluetoothDevice, finished: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let result = device.openConnection()
            DispatchQueue.main.async {
                finished(self.evaulateIOReturn(returnValue: result))
            }
        }
    }
    
    func disconnectFromDevice(device: IOBluetoothDevice, finished: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let result = device.closeConnection()
            DispatchQueue.main.async {
                finished(self.evaulateIOReturn(returnValue: result))
            }
        }
    }
    
    func evaulateIOReturn(returnValue: IOReturn) -> Bool {
        if returnValue != 0 {
            return false
        } else {
            return true
        }
    }
    
    func getBluetoothPowerState() -> Bool {
        let powerState = IOBluetoothPreferenceGetControllerPowerState()
        return powerState == 0 ? false : true
    }
    
    /*
     * inspired by blueutil by @toy (https://github.com/toy/blueutil/blob/master/blueutil.m)
     */
    func setBluetoothPowerState(state: Bool)  {
        let powerState: Int32 = state ? Int32(1) : Int32(0)
        IOBluetoothPreferenceSetControllerPowerState(powerState)
        for i in 0 ... 100 {
            if i != 0 {
                usleep(100000)
            }
            if state == getBluetoothPowerState() {
                return
            }
        }
    }
}

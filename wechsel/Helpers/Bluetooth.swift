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
    
    var devices = [IOBluetoothDevice]()

    private func fetchDevices() -> [IOBluetoothDevice] {
        guard var devices = IOBluetoothDevice.recentDevices(0) as? [IOBluetoothDevice] else {
            print("Error accessing IOBluetoothDevice.recentDevices")
            return []
        }
        
        devices = devices.filter { (device : IOBluetoothDevice) -> Bool in
            return device.deviceClassMajor == kBluetoothDeviceClassMajorAudio
        }
 
        //sort device array by connection state
        let sortedDevices = devices.sorted(by: {
            if $0.isConnected() && $1.isConnected() {
              return $0.recentAccessDate() > $1.recentAccessDate()
            } else if $0.isConnected() {
              return true
            } else {
              return false
            }
        })

        return sortedDevices
    }
    func refreshDeviceList() {
        self.devices = self.fetchDevices()
    }
    
    func getDevices() -> [IOBluetoothDevice] {
        return self.devices
    }
    
    func modifyConnection(device: IOBluetoothDevice, desiredState: Bool, finished: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .background).async {
            var result = Int32()
            if desiredState == false {
                result = device.closeConnection()
            }
            else if desiredState == true {
                result = device.openConnection()
            }
            DispatchQueue.main.async {
                finished(self.evaulateIOReturn(returnValue: result))
            }
        }
    }
    
    private func evaulateIOReturn(returnValue: IOReturn) -> Bool {
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
     * @todo: convert to async function to match connect/disconnect function
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
        print("Unable to set Bluetooth Power State")
    }
}

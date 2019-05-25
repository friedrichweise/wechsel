//
//  ViewController.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

enum ModalState {
    case ConnectionMode
    case BluetoothMode
}


class ViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!

    var bluetooth: Bluetooth = Bluetooth(numberOfDevices: Config.numberOfDevices)
    var state: ModalState = ModalState.ConnectionMode
    /* initalize view */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))
    }
    /* modal window gets shown */
    override func viewWillAppear() {
        super.viewWillAppear()
        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        tableView.scrollRowToVisible(0)
        reloadTableView()
    }
    
    /* interaction */
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        toggleConnectionState();
    }
    override func keyDown(with event: NSEvent) {
        //return or enter
        if ((event.keyCode == 36) || (event.keyCode == 76)) {
            toggleConnectionState()
        }
        //escape
        if (event.keyCode == 53) {
            closeModal()
        }
    }
    func toggleConnectionState() {
        guard tableView.selectedRow >= 0 else {
                return
        }
        
        let selectedCell = tableView.view(atColumn: 0, row: tableView.selectedRow, makeIfNecessary: false)
        if (selectedCell as? BluetoothTableCellView) != nil {
            self.bluetooth.setBluetoothPowerState(state: true)
            self.reloadTableView()
        }
        if let deviceCellView = selectedCell as? DeviceTableCellView {
            let device = self.bluetooth.getDevices()[tableView.selectedRow]
            deviceCellView.indicateProgress()
            let finishedHandler = {(success: Bool) -> Void in
                //hides the progress indicator and draws state image
                deviceCellView.indicateState()
                if success {
                    self.perform(#selector(self.closeModal), with: nil, afterDelay: 0)
                    self.reloadTableView()
                }
            }
            
            let desiredState = !device.isConnected()
            self.bluetooth.modifyConnection(device: device, desiredState: desiredState, finished: finishedHandler)
        }
    }
    func reloadTableView() {
        //preserve selection state
        let selectedRow = tableView.selectedRow
        
        if self.bluetooth.getBluetoothPowerState() == false {
            self.state = ModalState.BluetoothMode
        } else {
            self.state = ModalState.ConnectionMode
        }
        
        //refetch device list to incorperate connection changes
        self.bluetooth.refreshDeviceList()
        
        tableView.reloadData()

        //restore selection state
        tableView.selectRowIndexes(IndexSet(integer: selectedRow), byExtendingSelection: false)
    }
    
    @objc func closeModal() {
        if let window = self.view.window {
            window.close()
        }
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.bluetooth.getDevices().count
    }
}

extension ViewController: NSTableViewDelegate {
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        if self.state == ModalState.BluetoothMode && row != 0 {
            return false
        } else {
            return true;
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        
        // create Bluetooth Cell View
        if row == 0 && self.state == ModalState.BluetoothMode {
            return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "bluetoothRow"), owner: self) as! BluetoothTableCellView
        }
        
        let deviceView:DeviceTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "deviceRow"), owner: self) as! DeviceTableCellView
        let bluetoothDevices = self.bluetooth.getDevices()
        
        guard bluetoothDevices.indices.contains(row),
            let name = bluetoothDevices[row].nameOrAddress,
            let recentAccess = bluetoothDevices[row].recentAccessDate() else {
            return nil
        }
        
        deviceView.nameTextField.stringValue = name
        deviceView.lastUsedTextField.stringValue = timeAgoSince(recentAccess)
        deviceView.setConnectionState(connnected: bluetoothDevices[row].isConnected())

        if self.state == ModalState.BluetoothMode {
            deviceView.disabled()
        }
        
        return deviceView
    }
    
}

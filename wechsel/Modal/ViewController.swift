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
        
        if self.bluetooth.getBluetoothPowerState() == false {
            self.state = ModalState.BluetoothMode
        } else {
            self.state = ModalState.ConnectionMode
        }
        
        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
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
        let device = self.bluetooth.getDevices()[tableView.selectedRow]
        let deviceCellView = tableView.view(atColumn: 0, row: tableView.selectedRow, makeIfNecessary: false) as! DeviceTableCellView
        deviceCellView.indicateProgress()

        let finishedHandler = {(success: Bool) -> Void in
            self.reloadTableView()
            //hides the progress indicator and draws state image
            deviceCellView.indicateState()
            if success {
                self.perform(#selector(self.closeModal), with: nil, afterDelay: 1)
            }
        }
        
        if device.isConnected() {
            self.bluetooth.disconnectFromDevice(device: device, finished: finishedHandler)
        } else {
            self.bluetooth.connectToDevices(device: device, finished: finishedHandler)
        }
        
    }
    func reloadTableView() {
        let row = tableView.selectedRow
        tableView.reloadData()
        tableView.selectRowIndexes(IndexSet(integer: row), byExtendingSelection: false)
    }
    
    @objc func closeModal() {
        if let window = self.view.window {
            window.close()
        }
    }
}

extension ViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return Config.numberOfDevices
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
        
        if row == 0 && self.state == ModalState.BluetoothMode {
            return tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "bluetoothRow"), owner: self) as! BluetoothTableCellView
        }
        
        var deviceView:DeviceTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! DeviceTableCellView

        let bluetoothDevices = self.bluetooth.getDevices()
        
        guard bluetoothDevices.indices.contains(row),
            let name = bluetoothDevices[row].nameOrAddress,
            let recentAccess = bluetoothDevices[row].recentAccessDate() else {
            return nil
        }
        
        deviceView.nameTextField.stringValue = name
        deviceView.lastUsedTextField.stringValue = timeAgoSince(recentAccess)
        deviceView.setConnectionState(connnected: bluetoothDevices[row].isConnected())

        return deviceView
    }
    
}

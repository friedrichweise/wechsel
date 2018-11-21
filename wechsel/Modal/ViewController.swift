//
//  ViewController.swift
//  Connect
//
//  Created by Friedrich Weise on 13.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    var data: [[String: String]]?
    var bluetooth: Bluetooth = Bluetooth(numberOfDevices: Config.numberOfDevices)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        reloadTableView()
        
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))

    }
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        toggleConnectionState();
    }
    override func keyDown(with event: NSEvent) {
        //return or enter
        if ((event.keyCode == 36) || (event.keyCode == 76)) {
            toggleConnectionState()
            perform(#selector(closeModal), with: nil, afterDelay: 1)
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
        if device.isConnected() {
            self.bluetooth.disconnectFromDevice(device: device)
        } else {
            self.bluetooth.connectToDevices(device: device)
        }
        reloadTableView()
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
        return true;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView?{
        let deviceView:DeviceTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "defaultRow"), owner: self) as! DeviceTableCellView
        
        //@todo: should be moved to bluetooth helper class
        let bluetoothDevices = self.bluetooth.getDevices()
        guard bluetoothDevices.indices.contains(row) else {
            return nil
        }
        
        guard let name = bluetoothDevices[row].nameOrAddress, let recentAccess = bluetoothDevices[row].recentAccessDate() else {
            return nil
        }
        
        deviceView.nameTextField.stringValue = name
        deviceView.lastUsedTextField.stringValue = timeAgoSince(recentAccess)
    

        if bluetoothDevices[row].isConnected() {
            deviceView.imgView.image = NSImage.init(named: "statusEnabled")
        } else {
            deviceView.imgView.image = NSImage.init(named: "statusDisabled")
        }

        return deviceView
    }
    
}

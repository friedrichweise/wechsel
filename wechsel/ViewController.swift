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
    var store: ConnectionStore?
    var bridge: blueutilBridge?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bridge = blueutilBridge()
        self.store = self.bridge!.store

        tableView.reloadData()

        tableView.selectRowIndexes(IndexSet(integer: 0), byExtendingSelection: false)
        tableView.target = self
        tableView.doubleAction = #selector(tableViewDoubleClick(_:))

    }
    @objc func tableViewDoubleClick(_ sender:AnyObject) {
        closeModal()
        connectToSelectedDevice();
    }
    override func keyDown(with event: NSEvent) {
        //return or enter
        if ((event.keyCode == 36) || (event.keyCode == 76)) {
            closeModal()
            connectToSelectedDevice()
        }
        if (event.keyCode == 53) {
            closeModal()
        }
    }
    func connectToSelectedDevice() {
        guard tableView.selectedRow >= 0,
            let item = store!.getConnectionByID(id: tableView.selectedRow) else {
                return
        }
        self.bridge!.connectToDevice(address: item.address)
    }
    
    func closeModal() {
        NSApplication.shared.stopModal()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }

}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return store?.getConnectionsCount() ?? 0
    }
    
}

extension ViewController: NSTableViewDelegate {
    
    fileprivate enum CellIdentifiers {
        static let NameCell = "name"
        static let StatusCell = "status"
    }
    
    
   /* func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40.0
    }*/
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true;
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text: String = ""
        var cellIdentifier: String = ""
        
        //@todo: check before unwrapping optional
        guard let row = store!.getConnectionByID(id: row) else {
            return nil
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = row.name
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = String(row.connected)
            cellIdentifier = CellIdentifiers.StatusCell
        }
        
        // 3
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
    
}

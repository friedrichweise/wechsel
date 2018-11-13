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

    override func viewDidLoad() {
        super.viewDidLoad()
        let bridge = blueutilBridge()
        data = [
            [
                "name" : "Kusifiri",
                "status" : "5532612"
            ],
            [
                "name" : "UE Boom 2",
                "status" : "54329987"
            ],
            [
                "name" : "JBL Go",
                "status" : "53122543"
            ]
        ]
        tableView.reloadData()
        let indexSet = IndexSet(integer: 0)
        tableView.selectRowIndexes(indexSet, byExtendingSelection: false)
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

extension ViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data?.count ?? 0
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
        
        // 1
        guard let item = data?[row] else {
            return nil
        }
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item["name"]!
            cellIdentifier = CellIdentifiers.NameCell
        } else if tableColumn == tableView.tableColumns[1] {
            text = item["status"]!
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

//
//  MainWindow.swift
//  wechsel
//
//  Created by Friedrich Weise on 15.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    @IBOutlet var titleBarController: NSTitlebarAccessoryViewController!
    
    override var windowNibName : String! {
        return "MainWindow"
    }
    
    override func windowDidLoad() {
        titleBarController.layoutAttribute = .right
        // set the titleBar
        self.window?.addTitlebarAccessoryViewController(
            titleBarController
        )
        super.windowDidLoad()
        self.window?.center()
    }
    
}

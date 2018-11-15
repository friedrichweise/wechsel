//
//  MainMenuController.swift
//  wechsel
//
//  Created by Friedrich Weise on 15.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class MainMenuController: NSObject {
    @IBOutlet weak var mainMenu: NSMenu!
    
    var mainWindowController: MainWindowController!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        statusItem.menu = mainMenu
        statusItem.title = "wechsel"
        
        mainWindowController = MainWindowController()

    }
    
    
    @IBAction func showSwitcherClicked(_ sender: Any) {
        //mainWindow.showWindow(nil)
        if let window = mainWindowController.window {
            let application = NSApplication.shared
            NSApp.activate(ignoringOtherApps: true)
            window.makeKeyAndOrderFront(self)
            application.runModal(for: window)
            window.close()
        }
    }
    @IBAction func settingsClicked(_ sender: Any) {
        
    }
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
}

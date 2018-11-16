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
    
    let defaultsKey = Config.key
    var mainWindowController: MainWindowController!
    var preferenceWindowController: PreferenceWindowController!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        statusItem.menu = mainMenu
        statusItem.title = "wechsel"
        
        mainWindowController = MainWindowController()
        preferenceWindowController = PreferenceWindowController()
        
        //bind shortcut from user defaults to showModal func
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: defaultsKey, toAction: showModal)
    }
    @IBAction func showSwitcherClicked(_ sender: Any) {
        //mainWindow.showWindow(nil)
        showModal()
    }
    @IBAction func settingsClicked(_ sender: Any) {
        preferenceWindowController.showWindow(nil)
    }
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    func showModal() {
        if let window = mainWindowController.window {
            let application = NSApplication.shared
            NSApp.activate(ignoringOtherApps: true)
            window.makeKeyAndOrderFront(self)
            application.runModal(for: window)
            window.close()
        }
    }

}

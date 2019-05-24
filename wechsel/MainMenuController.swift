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
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarIcon"))
        }
        mainWindowController = MainWindowController()
        preferenceWindowController = PreferenceWindowController.shared
        
        //bind shortcut from user defaults to showModal func
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: defaultsKey, toAction: showModal)
        
        self.setModalKeyCodeForMenu()
        
        // add Observer for UserDefault changes of the ModalKeyCode
        UserDefaults.standard.addObserver(self, forKeyPath: defaultsKey, options: NSKeyValueObservingOptions.new, context: nil)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if(keyPath == defaultsKey) {
            self.setModalKeyCodeForMenu()
        }
    }
    func setModalKeyCodeForMenu() {
        //set shortcut of menu icon
        if let showModalMenuItem = mainMenu.item(withTag: 1) {
            if let serializedShortcut = UserDefaults.standard.data(forKey: defaultsKey) {
                let shortcut = NSKeyedUnarchiver.unarchiveObject(with: serializedShortcut) as! MASShortcut
                showModalMenuItem.keyEquivalent = shortcut.keyCodeStringForKeyEquivalent
                showModalMenuItem.keyEquivalentModifierMask = NSEvent.ModifierFlags(rawValue: shortcut.modifierFlags)
            }
        }
    }
    @IBAction func showSwitcherClicked(_ sender: Any) {
        showModal()
    }
    @IBAction func settingsClicked(_ sender: Any) {
        NSApp.activate(ignoringOtherApps: true)
        preferenceWindowController.showWindow(nil)
    }
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    func showModal() {
        if let window = mainWindowController.window {
            NSApp.activate(ignoringOtherApps: true)
            window.makeKeyAndOrderFront(self)
            window.orderFrontRegardless()
        }
    }
    deinit {
        UserDefaults.standard.removeObserver(self, forKeyPath: defaultsKey)
    }
}

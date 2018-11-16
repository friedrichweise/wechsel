//
//  PreferenceWindowController.swift
//  wechsel
//
//  Created by Friedrich Weise on 16.11.18.
//  Copyright © 2018 Friedrich Weise. All rights reserved.
//

import Cocoa

class PreferenceWindowController: NSWindowController {
    
    override var windowNibName : String! {
        return "PreferenceWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
}
